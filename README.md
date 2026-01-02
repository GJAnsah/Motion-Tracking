# 🎯 Motion Tracking

MATLAB-based motion tracking system using color detection and bounding boxes to quantify movement in video data.

## 📖 About

Built to computationally track motion as an alternative to tedious manual frame-by-frame video analysis. 

## 🔬 Use Cases

- Tracking limb/jaw motion during induced seizures
- Quantifying movement from motor cortex stimulation
- Validating accelerometer sensitivity against video analysis
- Any application requiring automated motion quantification from video

## ⚙️ How It Works

1. **Color filtering** — Isolates target object by RGB thresholds (e.g., filtering out pixels where red > 100 or green < 80)
2. **Noise removal** — Applies median filter and removes small objects (< 20 pixels)
3. **Object detection** — Labels connected regions and finds bounding boxes + centroids
4. **Tracking** — Selects the largest object per frame and logs its position
5. **Kinematics** — Computes velocity and acceleration from displacement using `diff()`

## 🚀 Usage

1. Set your video file and start time:
```matlab
videoSource = VideoReader('my_vid.mp4');
videoSource.CurrentTime = 0;  % start time in seconds
```

2. Adjust color thresholds to isolate your target object:
```matlab
Gmax = 0;   Gmin = 80;
Bmax = 60;  Bmin = 0;
Rmax = 100; Rmin = 0;
```

3. Run the script

## 📤 Outputs

| Variable | Description |
|----------|-------------|
| `T`, `W` | Bounding box displacement (x, y) |
| `C1`, `C2` | Centroid displacement (x, y) |
| `Vt` | Velocity (pixels/frame × 30) |
| `At` | Acceleration (pixels/frame² × 30) |

Variables saved to `VidAcc_variables.mat`

## 📦 Requirements
- MATLAB Image Processing Toolbox

## 📄 License

MIT
