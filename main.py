"""ژورنال معاملاتی فارکس — نقطه‌ی شروع برنامه."""
import os
import sys

from PySide6.QtCore import Qt
from PySide6.QtGui import QFont, QFontDatabase, QIcon
from PySide6.QtWidgets import QApplication

from app import theme
from app.database import data_dir
from app.utils import resource_path
from app.window import MainWindow


def main():
    app = QApplication(sys.argv)
    app.setApplicationName("ژورنال معاملاتی فارکس")
    app.setLayoutDirection(Qt.RightToLeft)

    # فونت‌های همراه برنامه (اگر Vazirmatn.ttf را داخل assets/fonts بگذاری خودکار بارگذاری می‌شود)
    fonts_dir = resource_path(os.path.join("assets", "fonts"))
    if os.path.isdir(fonts_dir):
        for f in os.listdir(fonts_dir):
            if f.lower().endswith((".ttf", ".otf")):
                QFontDatabase.addApplicationFont(os.path.join(fonts_dir, f))
    families = set(QFontDatabase.families())
    for name in ("Vazirmatn", "Vazir", "Segoe UI", "Tahoma"):
        if name in families:
            app.setFont(QFont(name, 10))
            break

    arrow = data_dir() / "arrow.png"
    theme.make_arrow(str(arrow))
    app.setStyleSheet(theme.stylesheet(str(arrow)))
    app.setWindowIcon(QIcon(resource_path(os.path.join("assets", "icon.png"))))

    win = MainWindow()
    win.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
