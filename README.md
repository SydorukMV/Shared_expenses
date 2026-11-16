# Shared Expenses (shared_expenses)

Кросплатформний Flutter-застосунок для обліку витрат групи користувачів
і визначення частки кожного учасника (дисципліна «Кросплатформне
програмування», варіант 25).

## Стан розробки

| ЛР | Зміст |
|----|-------|
| 1 | Створення Flutter-проєкту |
| 2 | Специфікація вимог і прототип інтерфейсу (поза репозиторієм) |
| 3 | Базова структура застосунку та основні екрани без бізнес-логіки |
| 4 | Firebase: Authentication, Analytics, Crashlytics; валідація форм |

Автентифікація працює через Firebase Authentication (email і пароль):
реєстрація, вхід, відновлення пароля через електронну пошту, відновлення
сеансу, вихід, редагування профілю, зміна фото (готові HTTPS-зображення
або власне посилання) і зміна пароля. Групи та витрати поки hardcoded
(`lib/data/mock_data.dart`).

## Структура `lib/`

```
lib/
├── main.dart            точка входу, ініціалізація Firebase і Crashlytics
├── app.dart             MaterialApp: теми, маршрути, спостерігач Analytics
├── firebase_options.dart конфігурація FlutterFire
├── core/                спільний код
│   ├── constants/       відступи, готові фото профілю
│   ├── di/              AppScope: доступ до репозиторіїв і сервісів
│   ├── routes/          іменовані маршрути
│   ├── services/        AnalyticsService
│   ├── theme/           кольори та теми Material 3
│   ├── utils/           форматування, валідатори, SnackBar
│   └── widgets/         перевикористовувані віджети
├── data/
│   ├── models/          моделі даних
│   ├── repositories/    AuthRepository, ProfileRepository, AuthFailure
│   └── mock_data.dart   тестові дані груп і витрат
└── features/            екрани за функціональними розділами
    ├── auth/
    ├── home/
    ├── groups/
    ├── expenses/
    ├── profile/
    └── shell/           нижня навігація
```

## Запуск

```
flutter pub get
flutter run
```
