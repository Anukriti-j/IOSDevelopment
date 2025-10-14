import SwiftUI
import PhotosUI

struct GalleryView: View {
    @StateObject private var galleryViewModel = GalleryViewModel()
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var showActionSheet = false
    @State private var showCameraPicker = false
    @State private var showPhotosPicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var photosToShare: [UIImage] = []
    @State private var showShareSheet = false
    
    private let spacing: CGFloat = 2
    
    private let columns = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 4 - 2), spacing: 2)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                addButton
                photoGrid
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    selectCancelButton
                }
                if galleryViewModel.isSelectionMode {
                    bottomToolbarButtons
                }
            }
            .actionSheet(isPresented: $showActionSheet, content: actionSheet)
            .sheet(isPresented: $showCameraPicker) {
                PickImageView(galleryViewModel: galleryViewModel, sourceType: sourceType)
            }
            .photosPicker(
                isPresented: $showPhotosPicker,
                selection: $selectedItems,
                maxSelectionCount: 5,
                matching: .images
            )
            .onChange(of: selectedItems) { _, newItems in
                Task {
                    await galleryViewModel.handlePhotoSelection(items: newItems)
                    selectedItems.removeAll()
                }
            }
            .overlay {
                if galleryViewModel.isFetchingLocation {
                    ProgressView("Fetching location...").padding()
                }
            }
            .sheet(item: $galleryViewModel.selectedImageForDetail) { photo in
                ImageDetailView(photo: photo)
            }
            .onAppear {
                galleryViewModel.loadSavedImages()
            }
            .sheet(isPresented: $showShareSheet) {
                ShareSheetView(items: photosToShare)
            }
        }
    }
}

private extension GalleryView {
    
    var addButton: some View {
        Button {
            showActionSheet = true
        } label: {
            Label("Add", systemImage: "plus")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
    
    var selectCancelButton: some View {
        Button(galleryViewModel.isSelectionMode ? "Cancel" : "Select") {
            withAnimation {
                if galleryViewModel.isSelectionMode {
                    galleryViewModel.clearSelection()
                } else {
                    galleryViewModel.isSelectionMode = true
                }
            }
        }
    }
    
    var bottomToolbarButtons: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            Button(action: deleteSelectedPhotos) {
                Label("Delete", systemImage: "trash")
            }
            Spacer()
            Button(action: shareSelectedPhotos) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
        }
    }
    
    var photoGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(galleryViewModel.photos) { photo in
                    photoGridItem(photo: photo)
                }
            }
            .padding(spacing)
            .animation(.easeInOut, value: galleryViewModel.selectedPhotos)
        }
    }
    
    @ViewBuilder
    func photoGridItem(photo: Photo) -> some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: photo.image)
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .clipped()
                .cornerRadius(4)
                .contextMenu {
                    Button {
                        photosToShare = [photo.image]
                        showShareSheet = true
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    Button(role: .destructive) {
                        withAnimation {
                            galleryViewModel.deletePhoto(photo)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .opacity(galleryViewModel.isSelectionMode && !galleryViewModel.selectedPhotos.contains(photo.id) ? 0.7 : 1)
                .onTapGesture {
                    if galleryViewModel.isSelectionMode {
                        galleryViewModel.toggleSelection(for: photo)
                    } else {
                        galleryViewModel.selectImageForDetail(photo)
                    }
                }
            
            if galleryViewModel.isSelectionMode {
                Image(systemName: galleryViewModel.selectedPhotos.contains(photo.id) ? "checkmark.circle.fill" : "circle")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(6)
            }
        }
        .transition(.scale.combined(with: .opacity))
    }
    
    func deleteSelectedPhotos() {
        withAnimation {
            galleryViewModel.deletePhotos(withIDs: Array(galleryViewModel.selectedPhotos))
            galleryViewModel.clearSelection()
        }
    }
    
    func shareSelectedPhotos() {
        let selectedPhotos = galleryViewModel.photos.filter { galleryViewModel.selectedPhotos.contains($0.id) }
        photosToShare = selectedPhotos.map { $0.image }
        
        if !photosToShare.isEmpty {
            showShareSheet = true
        }
    }
    
    func actionSheet() -> ActionSheet {
        ActionSheet(
            title: Text("Choose Source"),
            buttons: [
                .default(Text("Camera")) {
                    sourceType = .camera
                    showCameraPicker = true
                },
                .default(Text("Photo Library")) {
                    sourceType = .photoLibrary
                    showPhotosPicker = true
                },
                .cancel()
            ]
        )
    }
}
