import cv2
import numpy as np

def add_gaussian_noise(image, mean=0, var=0.01):
    row, col, ch = image.shape
    sigma = var ** 0.5
    gauss = np.random.normal(mean, sigma, (row, col, ch))
    noisy = image + gauss.reshape(row, col, ch)
    return np.clip(noisy, 0, 255).astype(np.uint8)

def add_salt_and_pepper_noise(image, s_vs_p=0.5, amount=0.004):
    row, col, ch = image.shape
    out = np.copy(image)
    # Salt mode
    num_salt = np.ceil(amount * image.size * s_vs_p)
    coords = [np.random.randint(0, i - 1, int(num_salt))
              for i in image.shape]
    out[tuple(coords)] = 1

    # Pepper mode
    num_pepper = np.ceil(amount * image.size * (1. - s_vs_p))
    coords = [np.random.randint(0, i - 1, int(num_pepper))
              for i in image.shape]
    out[tuple(coords)] = 0
    return out

def add_poisson_noise(image):
    vals = len(np.unique(image))
    vals = 2 ** np.ceil(np.log2(vals))
    noisy = np.random.poisson(image * vals) / float(vals)
    return np.clip(noisy, 0, 255).astype(np.uint8)


def apply_low_pass_filter(image):
    kernel = np.ones((5, 5), np.float32) / 25
    return cv2.filter2D(image, -1, kernel)

def apply_high_pass_filter(image):
    kernel = np.array([[0, -1, 0],
                       [-1, 4, -1],
                       [0, -1, 0]])
    return cv2.filter2D(image, -1, kernel)

def detect_edges(image):
    # 使用 Canny 算法检测边缘
    edges = cv2.Canny(image, 100, 200)
    # 创建一个彩色图像用于显示边缘
    edge_colored = cv2.cvtColor(edges, cv2.COLOR_GRAY2BGR)
    return edge_colored


def apply_gaussian_blur(image, ksize=5):
    # 高斯模糊
    return cv2.GaussianBlur(image, (ksize, ksize), 0)

def sharpen_image(image):
    kernel = np.array([[-1, -1, -1],
                       [-1, 9, -1],
                       [-1, -1, -1]])
    return cv2.filter2D(image, -1, kernel)

def apply_median_blur(image, ksize=5):
    # 中值模糊
    return cv2.medianBlur(image, ksize)

def adjust_contrast(image, contrast=1.5):
    # 增强对比度
    f = 131 * (contrast - 1)
    alpha_c = f / 127 + 1
    gamma_c = 127 * (1 - alpha_c)
    image = cv2.addWeighted(image, alpha_c, image, 0, gamma_c)
    return image


