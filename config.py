import os
from semseg.data_loader import SemSegConfig

logs_folder = "logs"

train_images_folder = "H:\Datasets\Task04_Hippocampus\imagesTr"
train_labels_folder = "H:\Datasets\Task04_Hippocampus\labelsTr"

train_prediction_folder = "H:\Datasets\Task04_Hippocampus\predTr"
os.makedirs(train_prediction_folder, exist_ok=True)

train_images = os.listdir(train_images_folder)
train_labels = os.listdir(train_labels_folder)

train_images = [train_image for train_image in train_images
                if train_image.endswith(".nii.gz")]
train_labels = [train_image for train_image in train_images
                if train_image.endswith(".nii.gz")]

test_images_folder = "H:\Datasets\Task04_Hippocampus\imagesTs"

test_images = os.listdir(test_images_folder)


class SemSegMRIConfig(SemSegConfig):
    train_images = [os.path.join(train_images_folder, train_image)
                    for train_image in train_images]
    train_labels = [os.path.join(train_labels_folder, train_label)
                    for train_label in train_labels]
    do_normalize = True
    augmentation = None
    batch_size = 1
    num_workers = 0
    lr = 0.01
    epochs = 20
    low_lr_epoch = epochs // 5
    val_epochs = epochs // 5
    cuda = True
    num_outs = 3