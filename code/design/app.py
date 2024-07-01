from PyQt5 import QtWidgets, QtGui, QtCore
from PyQt5.QtWidgets import QMainWindow, QLabel, QTabWidget, QVBoxLayout, QPushButton, QFileDialog, QWidget, QDialog, QLineEdit
from PyQt5.QtWidgets import QSlider, QFileDialog
from PyQt5.QtCore import Qt
import cv2
import sys
import numpy as np
import os
# 引入处理模块
import convolution_kernels
import image_process
import image_effects
import image_transformations

class ImageDisplayWindow(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Image Display")
        self.setGeometry(150, 150, 800, 600)
        self.image_label = QLabel(self)
        self.image_label.resize(800, 600)
        self.image_label.setAlignment(QtCore.Qt.AlignCenter)

    def display_image(self, img):
        img = QtGui.QImage(img.data, img.shape[1], img.shape[0], QtGui.QImage.Format_RGB888).rgbSwapped()
        pixmap = QtGui.QPixmap.fromImage(img)
        self.image_label.setPixmap(pixmap.scaled(self.image_label.size(), QtCore.Qt.KeepAspectRatio))
        self.show()

class ImageProcessorApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Image Processing App")
        self.setGeometry(100, 100, 800, 600)

        self.image_display_window = ImageDisplayWindow(self)

        self.image = None

        # 创建标签页
        tab_widget = QTabWidget(self)
        self.conv_page = QWidget()
        self.process_page = QWidget()  # 更改变量名
        self.effects_page = QWidget()
        self.transform_page = QWidget()

        tab_widget.addTab(self.conv_page, "Convolution Operations")
        tab_widget.addTab(self.process_page, "Image Process")  # 更改标签页标题
        tab_widget.addTab(self.effects_page, "Image Effects")
        tab_widget.addTab(self.transform_page, "Image Transformations")

        self.create_convolution_controls()
        self.create_process_controls()  # 更改方法名称
        self.create_effects_controls()
        self.create_transformation_controls()

        layout = QVBoxLayout()
        layout.addWidget(tab_widget)

        container = QWidget()
        container.setLayout(layout)
        self.setCentralWidget(container)

        # 添加上传图片按钮
        upload_button = QPushButton("Upload Image", self)
        upload_button.clicked.connect(self.upload_image)
        layout.addWidget(upload_button)

    def upload_image(self):
        file_name, _ = QFileDialog.getOpenFileName(self, "Open Image", "", "Image Files (*.png *.jpg *.jpeg *.bmp)")
        print(file_name)
        if file_name:
            self.image = cv2.cvtColor(cv2.imread(file_name), cv2.COLOR_BGR2RGB)
            self.image_display_window.display_image(self.image)


    def apply_filter(self, filter_func):
        if self.image is not None:
            processed_image = filter_func(self.image)
            self.image_display_window.display_image(processed_image)

    def create_convolution_controls(self):
        layout = QVBoxLayout()
        # 创建低通滤波器按钮
        lp1_button = QPushButton("Apply Lowpass Filter 1")
        lp1_button.clicked.connect(lambda: self.apply_filter(convolution_kernels.kernel_lowpass_1))
        layout.addWidget(lp1_button)

        lp2_button = QPushButton("Apply Lowpass Filter 2")
        lp2_button.clicked.connect(lambda: self.apply_filter(convolution_kernels.kernel_lowpass_2))
        layout.addWidget(lp2_button)

        lp3_button = QPushButton("Apply Lowpass Filter 3")
        lp3_button.clicked.connect(lambda: self.apply_filter(convolution_kernels.kernel_lowpass_3))
        layout.addWidget(lp3_button)

        # 创建高通滤波器按钮
        hp1_button = QPushButton("Apply Highpass Filter 1")
        hp1_button.clicked.connect(lambda: self.apply_filter(convolution_kernels.kernel_highpass_1))
        layout.addWidget(hp1_button)

        hp2_button = QPushButton("Apply Highpass Filter 2")
        hp2_button.clicked.connect(lambda: self.apply_filter(convolution_kernels.kernel_highpass_2))
        layout.addWidget(hp2_button)

        hp3_button = QPushButton("Apply Highpass Filter 3")
        hp3_button.clicked.connect(lambda: self.apply_filter(convolution_kernels.kernel_highpass_3))
        layout.addWidget(hp3_button)

        # 创建移动检测滤波器按钮
        move_horizontal_button = QPushButton("Horizontal Movement Detection")
        move_horizontal_button.clicked.connect(
            lambda: self.apply_filter(convolution_kernels.kernel_move_detection_horizontal))
        layout.addWidget(move_horizontal_button)

        move_vertical_button = QPushButton("Vertical Movement Detection")
        move_vertical_button.clicked.connect(
            lambda: self.apply_filter(convolution_kernels.kernel_move_detection_vertical))
        layout.addWidget(move_vertical_button)

        move_diagonal_button = QPushButton("Diagonal Movement Detection")
        move_diagonal_button.clicked.connect(
            lambda: self.apply_filter(convolution_kernels.kernel_move_detection_diagonal))
        layout.addWidget(move_diagonal_button)

        # 创建边缘检测按钮
        for i in range(1, 5):
            button = QPushButton(f"Apply Edge Detection {i}")
            button.clicked.connect(lambda _, k=i: self.apply_filter(getattr(convolution_kernels, f'kernel_edge_{k}')))
            layout.addWidget(button)

        # 创建梯度检测按钮
        for i in range(1, 9):
            button = QPushButton(f"Apply Gradient {i}")
            button.clicked.connect(
                lambda _, k=i: self.apply_filter(getattr(convolution_kernels, f'kernel_gradient_{k}')))
            layout.addWidget(button)

        self.conv_page.setLayout(layout)

    def create_process_controls(self):
        layout = QVBoxLayout()

        # 添加 Gaussian 噪声按钮和均值滑动条
        gauss_noise_button = QPushButton("Add Gaussian Noise")

        # 均值滑动条
        gauss_mean_slider = QSlider(Qt.Horizontal)
        gauss_mean_slider.setMinimum(-255)  # 最小值，示例为允许负均值
        gauss_mean_slider.setMaximum(255)  # 最大值
        gauss_mean_slider.setValue(0)  # 默认值为0
        gauss_mean_label = QLabel("Mean: 0")
        gauss_mean_slider.valueChanged.connect(
            lambda value: gauss_mean_label.setText(f"Mean: {value}")
        )
        layout.addWidget(gauss_mean_label)
        layout.addWidget(gauss_mean_slider)

        # 方差设置为默认值，不提供滑动条
        default_variance = 0.1  # 默认方差值

        gauss_noise_button.clicked.connect(lambda: self.apply_filter(
            lambda img: image_process.add_gaussian_noise(img, gauss_mean_slider.value(), default_variance)
        ))
        layout.addWidget(gauss_noise_button)

        # 添加 Salt and Pepper 噪声按钮和滑动条
        sp_noise_button = QPushButton("Add Salt and Pepper Noise")
        sp_amount_slider = QSlider(Qt.Horizontal)
        sp_amount_slider.setMinimum(1)
        sp_amount_slider.setMaximum(100)  # 代表比例从0.01到1.00
        sp_amount_slider.setValue(4)  # 默认值为0.04
        sp_amount_slider.valueChanged.connect(lambda value: sp_amount_label.setText(f"Amount: {value / 1000:.3f}"))
        sp_amount_label = QLabel("Amount: 0.004")
        layout.addWidget(sp_amount_label)
        layout.addWidget(sp_amount_slider)

        sp_noise_button.clicked.connect(lambda: self.apply_filter(
            lambda img: image_process.add_salt_and_pepper_noise(img, 0.5, sp_amount_slider.value() / 1000)
        ))
        layout.addWidget(sp_noise_button)

        # 添加其他图像处理操作的按钮
        self.add_other_image_processing_buttons(layout)

        self.process_page.setLayout(layout)

    def add_other_image_processing_buttons(self, layout):
        # 创建其他图像处理按钮并添加到布局
        low_pass_button = QPushButton("Apply Low Pass Filter")
        high_pass_button = QPushButton("Apply High Pass Filter")
        edge_detect_button = QPushButton("Detect Edges")
        gaussian_blur_button = QPushButton("Apply Gaussian Blur")
        sharpen_button = QPushButton("Sharpen Image")
        median_blur_button = QPushButton("Apply Median Blur")
        adjust_contrast_button = QPushButton("Adjust Contrast")

        low_pass_button.clicked.connect(lambda: self.apply_filter(image_process.apply_low_pass_filter))
        high_pass_button.clicked.connect(lambda: self.apply_filter(image_process.apply_high_pass_filter))
        edge_detect_button.clicked.connect(lambda: self.apply_filter(image_process.detect_edges))
        gaussian_blur_button.clicked.connect(
            lambda: self.apply_filter(lambda img: image_process.apply_gaussian_blur(img, 5)))
        sharpen_button.clicked.connect(lambda: self.apply_filter(image_process.sharpen_image))
        median_blur_button.clicked.connect(
            lambda: self.apply_filter(lambda img: image_process.apply_median_blur(img, 5)))
        adjust_contrast_button.clicked.connect(
            lambda: self.apply_filter(lambda img: image_process.adjust_contrast(img, 1.5)))

        layout.addWidget(low_pass_button)
        layout.addWidget(high_pass_button)
        layout.addWidget(edge_detect_button)
        layout.addWidget(gaussian_blur_button)
        layout.addWidget(sharpen_button)
        layout.addWidget(median_blur_button)
        layout.addWidget(adjust_contrast_button)

    def create_effects_controls(self):
        layout = QVBoxLayout()

        # 添加马赛克效果按钮和滑动条
        mosaic_button = QPushButton("Apply Mosaic Effect")
        mosaic_slider = QSlider(Qt.Horizontal)
        mosaic_slider.setMinimum(5)  # 最小块大小
        mosaic_slider.setMaximum(50)  # 最大块大小
        mosaic_slider.setValue(10)  # 默认块大小为 10
        mosaic_label = QLabel("Block Size: 10")
        mosaic_slider.valueChanged.connect(lambda value: mosaic_label.setText(f"Block Size: {value}"))
        mosaic_button.clicked.connect(lambda: self.apply_filter(
            lambda img: image_effects.apply_mosaic(img, mosaic_slider.value())
        ))
        layout.addWidget(mosaic_label)
        layout.addWidget(mosaic_slider)
        layout.addWidget(mosaic_button)

        # 添加晕影效果按钮和滑动条
        vignette_button = QPushButton("Apply Vignette Effect")
        vignette_slider = QSlider(Qt.Horizontal)
        vignette_slider.setMinimum(10)  # 最小强度
        vignette_slider.setMaximum(100)  # 最大强度，对应于 0.1 到 1.0 的范围
        vignette_slider.setValue(50)  # 默认强度为 0.5
        vignette_label = QLabel("Vignette Strength: 0.5")
        vignette_slider.valueChanged.connect(
            lambda value: vignette_label.setText(f"Vignette Strength: {value / 100:.2f}")
        )
        vignette_button.clicked.connect(lambda: self.apply_filter(
            lambda img: image_effects.apply_vignette(img, vignette_slider.value() / 100)
        ))
        layout.addWidget(vignette_label)
        layout.addWidget(vignette_slider)
        layout.addWidget(vignette_button)

        # 添加其他效果的按钮
        thermal_button = QPushButton("Apply Thermal Effect")
        thermal_button.clicked.connect(lambda: self.apply_filter(image_effects.apply_thermal_effect))
        layout.addWidget(thermal_button)

        sketch_button = QPushButton("Apply Sketch Effect")
        sketch_button.clicked.connect(lambda: self.apply_filter(
            lambda img: image_effects.apply_sketch_effect(img, 60, 0.07)  # 默认参数
        ))
        layout.addWidget(sketch_button)

        cartoon_button = QPushButton("Apply Cartoon Effect")
        cartoon_button.clicked.connect(lambda: self.apply_filter(image_effects.apply_cartoon_effect))
        layout.addWidget(cartoon_button)

        self.effects_page.setLayout(layout)


    def create_transformation_controls(self):
        layout = QVBoxLayout()

        # 添加缩放控制滑动条和按钮
        scale_label = QLabel("Scale Factor: 1.0", self)
        scale_slider = QSlider(Qt.Horizontal, self)
        scale_slider.setMinimum(1)
        scale_slider.setMaximum(200)  # 设定范围，例如 0.1 到 2.0 倍，内部表示为 10 到 200
        scale_slider.setValue(100)  # 默认值为 1.0，内部表示为 100
        scale_slider.valueChanged.connect(lambda value: scale_label.setText(f"Scale Factor: {value / 100:.2f}"))

        scale_button = QPushButton("Apply Scaling")
        scale_button.clicked.connect(lambda: self.apply_filter(
            lambda img: image_transformations.resize_image(img, scale_slider.value() / 100)
        ))
        layout.addWidget(scale_label)
        layout.addWidget(scale_slider)
        layout.addWidget(scale_button)

        # 添加旋转控制滑动条和按钮
        rotate_label = QLabel("Rotate Angle: 0°", self)
        rotate_slider = QSlider(Qt.Horizontal, self)
        rotate_slider.setMinimum(0)
        rotate_slider.setMaximum(360)  # 允许旋转的角度从 0 到 360 度
        rotate_slider.setValue(0)  # 默认值为 0 度
        rotate_slider.valueChanged.connect(lambda value: rotate_label.setText(f"Rotate Angle: {value}°"))

        rotate_button = QPushButton("Apply Rotation")
        rotate_button.clicked.connect(lambda: self.apply_filter(
            lambda img: image_transformations.rotate_image(img, rotate_slider.value())
        ))
        layout.addWidget(rotate_label)
        layout.addWidget(rotate_slider)
        layout.addWidget(rotate_button)

        self.transform_page.setLayout(layout)


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    main_window = ImageProcessorApp()
    main_window.show()
    sys.exit(app.exec_())
