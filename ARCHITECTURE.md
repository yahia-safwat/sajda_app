# Clean Architecture Guidelines (Flutter)

This project strictly follows **Clean Architecture** principles to ensure scalability, testability, and maintainability.

Each feature is isolated and organized into **three main layers**:
- Presentation
- Domain
- Data

Cross-cutting helpers and shared logic live in a separate `utils` (or `core`) layer.

---

## 📁 Project Structure

lib/
├── features/
│   ├── feature_name/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   ├── widgets/
│   │   │   └── blocs/
│   │   ├── domain/
│   │   │   ├── repositories/
│   │   │   ├── usecases/
│   │   │   └── entities/
│   │   └── data/
│   │       ├── data_sources/
│   │       │   ├── local/
│   │       │   ├── remote/
│   │       │   └── static/
│   │       ├── repositories/
│   │       └── models/
│   └── (other features)
├── core/
│   ├── constants/
│   ├── themes/
│   └── utils/
└── main.dart