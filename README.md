<h1 align="center">
  <br>
  <img src="Documentation/Screenshots/logo.png" alt="QuizGit" width="200">
  <br>
  QuizGit - Интерактивное обучение Git
  <br>
</h1>

[![Swift](https://img.shields.io/badge/Swift-6-orange.svg)](https://swift.org/)
[![Firebase](https://img.shields.io/badge/Firebase-13.0-red.svg)](https://firebase.google.com)

- 🎮 Интерактивное приложение для изучения Git через квизы 
- ✅ SwiftUI + Firebase | Статистика | Рейтинги | Персонализация
- 🚀 Для iOS 17+ 

## 📋 Оглавление
1. [Функциональные возможности](#✨-функциональные-возможности)
2. [Архитектура приложения](#🏗️-архитектура-приложения)
3. [Модели данных](#📦-модели-данных)
4. [UI-компоненты](#🎨-ui-компоненты)
5. [Сервисы](#🔌-сервисы)
6. [Функциональная схема](#🔧-функциональная-схема)
7. Слои архитектуры
---

## ✨ Функциональные возможности

### Основные функции
- **📚 Тестирование знаний**: категории вопросов по Git
- **🏆 Рейтинг игроков**: Топ-100 пользователей
- **⚙️ Настройки теста**: 
  - Выбор количества вопросов (5-50)
  - Настройка времени на ответ (10-60 сек)
  - Управление подсказками
  - Выбор темы
- **👤 Редактирование профиля**:
  - Редактирование имени
  - Смена пароля
  - Удаление аккаунта

### Дополнительные функции
- **📊 Статистика**: 
  - Общее время в игре
  - Процент правильных ответов
  - Использованные подсказки
  - Детальная статистика
- **🎭 Темная/светлая тема**
- **🌍 Локализация**: Русский/Английский (в разработке)

---

## 🏗️ Архитектура приложения (27 из 45)

### Модели данных
| Модель              | Описание                                      |
|---------------------|-----------------------------------------------|
| `Profile`           | Данные пользователя (имя, email, аватар)      |
| `QuizConfig`        | Настройки теста (время, кол-во вопросов)      |
| `UserStatistics`    | Статистика игрока (очки, время, ответы)       |
| `AppSettings`       | Настройки приложения (тема, язык, уведомления)|
| `Question`          | Вопрос с вариантами ответов и подсказкой      |
| `Category`          | Выбираемая пользователем тема теста           |
| `LeaderboardUser`   | Данные для рейтинга                           |
| `GameResults`       | Результаты в конце игры                       |

### Сервисы
| Сервис               | Ответственность                               |
|----------------------|-----------------------------------------------|
| `FirestoreService`   | Работа с Firestore (CRUD операции)            |
| `AuthService`        | Аутентификация (регистрация, вход, выход)     |
| `StatisticsManager`  | Обновление игровой статистики                 |
| `QuestionStorage`    | Кеширование вопросов из Firebase              |

### ViewModel
| ViewModel              | Функционал                                  |
|------------------------|---------------------------------------------|
| `GameViewModel`        | Логика игрового процесса                    |
| `SettingsViewModel`    | Управление настройками и профилем           |
| `LeaderboardViewModel` | Работа с рейтинговой таблицей               |
| `StatisticsViewModel`  | Работа со статистикой пользователя          |

### Экранная модель
| Экран                | Компоненты                                    |
|----------------------|-----------------------------------------------|
| `AuthView`           | Экран регистрации и авторизации               |
| `HomeView`           | Главный экран с выбором категорий             |
| `GameView`           | Интерфейс тестирования                        |
| `ProfileView`        | Редактирование профиля                        |
| `StatisticsView`     | Детальная статистика игрока                   |
| `RatingView`         | Рейтинговая таблица игроков                   |
| `SettingsView`       | Настройки приложения и редактирование профиля |
| `ResultsView`        | Показ статистики после игры                   |
| `SideBarMenuView`    | Боковое меню для навигации по экранам         |
| `TestSettingsView`   | Экран настройки теста                         |
| `ThemeChangeView`    | Анимированный экран выбора темы               |

---
## 🎨 UI-компоненты
### 1. HintView
```swift
struct HintView: View {
    let hint: Hint
    @Binding var isPresented: Bool
}
```
Отображает модальное окно с подсказкой

**Содержит**:
- Иконку лампочки
- Текст подсказки
- Ссылку на документацию
- Кнопку закрытия
  
### 2. ErrorView
```swift
struct ErrorView: View {
    let message: String
    var retryAction: (() -> Void)? = nil
}
```
Показывает ошибки в едином стиле

**Предоставляет**:
- Иконку ошибки
- Сообщение об ошибке
- Кнопку повтора
- Кнопку возврата на главную

### 3. ResultsView
```swift
struct ResultsView: View {
    let results: GameResults
    @Environment(\.presentationMode) var presentationMode
}
```
**Визуализирует итоги игры**:
- Количество правильных ответов
- Затраченное время
- Использованные подсказки
- Итоговый счет
- Анимированный фон кнопки с градиентом

### 4. CategoryButtonView
```swift
struct CategoryButtonView: View {
    let category: Category
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
        }
    }
```
**Кнопка выбора категории теста**
- Анимация выбора

### 5. DetailedStatsView
```swift
struct DetailedStatsView: View {
    @ObservedObject var viewModel: StatisticsViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            SectionHeader(title: "Детальная статистика")
            
            VStack(spacing: 8) { }
          }
    }
```
**Отображение секции детальной статистики для экрана статистики**

### 6. AnimatedSideBar
```swift
struct AnimatedSideBar<Content: View, MenuView: View, Background: View>: View {
    var rotatesWhenExpands:Bool = true
    var disablesInteraction:Bool = true
    var sideMenuWidth:CGFloat = 200
    var cornerRadius:CGFloat = 25
    @Binding var showMenu: Bool
    @Binding var selectedTab: Tab
    @ViewBuilder var content: (UIEdgeInsets) -> Content
    @ViewBuilder var menuView: (UIEdgeInsets) -> MenuView
    @ViewBuilder var background: Background
    ///View Properties
    @GestureState private var isDragging: Bool = false
    @State private var offsetX: CGFloat = 0
    @State private var lastOffsetX: CGFloat = 0
    @State private var progress: CGFloat = 0
    
    var body: some View {
        GeometryReader{
            let size = $0.size
        }
  }
```
**Реализует компонент бокового меню с**:
- Анимацией на основе жестов и программного управления
- Кастомизацией внешнего вида и поведения
- Поддержкой безопасных зон (SafeArea)
- Оптимизированным рендерингом через GeometryReader и ViewBuilder.

### 7. InfiniteScrollView
```swift
struct InfiniteScrollView<Content: View>: View {
    var spacing: CGFloat = 20
    @ViewBuilder var content: Content
    
    @State private var contentSize: CGSize = .zero
    var body: some View {
        GeometryReader{
            let size = $0.size
            ScrollView(.horizontal){
                HStack(spacing: spacing){
                    if #available(iOS 18.0, *) {
                        Group(subviews: content){ collection in
                            // Original content
                            HStack(spacing: spacing){
                                ForEach(collection){ view in
                                    view
                                }
                            }
                            .onGeometryChange(for: CGSize.self) {
                                $0.size
                            } action: { newValue in
                                contentSize = .init(width: newValue.width + spacing, height: newValue.height)
                            }
                            
                            let averageWidth = contentSize.width / CGFloat(collection.count)
                            let repeatingCount = contentSize.width > 0 ? Int((size.width / averageWidth).rounded()) + 1 : 1
                            
                            HStack(spacing: spacing) {
                                ForEach(0..<repeatingCount, id: \.self){ index in
                                    let view = Array(collection)[index % collection.count]
                                    
                                    view
                                }
                            }
                            
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }
                .background(InfiniteScrollHelper(declarationRate: .constant(.fast), contentSize: $contentSize))
            }
        }
    }
}
```
**Создает бесконечную горизонтальную ленту элементов с**:
- Нативным ощущением прокрутки
- Поддержкой кастомного контента
- Автоматической подстройкой под размер экрана.

### 8. QuestionCardView
```swift
struct QuestionCardView: View {
    let question: Question
    @State private var shuffledAnswers: [String]
    @Binding var selectedAnswerIndex: Int?
    let onAnswerSelected: (Int) -> Void
    
    init(question: Question, selectedAnswerIndex: Binding<Int?>, onAnswerSelected: @escaping (Int) -> Void) {
        self.question = question
        self._selectedAnswerIndex = selectedAnswerIndex
        self.onAnswerSelected = onAnswerSelected
        
        // Перемешиваем ответы при инициализации
        let shuffled = self.question.answers.shuffled()
        self.shuffledAnswers = shuffled
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Карточка с вопросом
            ...
        }
        // Список ответов
        ...
    }
    ...
    private func isCorrectAnswer(_ index: Int) -> Bool {
        guard let originalIndex = question.answers.firstIndex(of: question.answers[index]) else {
            return false
        }
        return originalIndex == question.correctAnswerIndex
    }
    
    private func handleAnswerSelection(at index: Int) {
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedAnswerIndex = index
            onAnswerSelected(index)
        }
    }
Ъ
```
**Реализует карточку вопроса со списком ответов**:
- Мониторинг выбранного ответа
- Проверка правильности ответа

### 9. AnswerButtonView
```swift
struct AnswerButtonView: View {
    let text: String
    let isCorrect: Bool
    let isSelected: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if isSelected {
            return isCorrect ? .green : .red
        }
        return Color.blue.opacity(0.2)
    }
    
    var textColor: Color {
        isSelected ? .white : .primary
    }
    
    var body: some View {

            Button(action: action) {
                HStack {
                    Text(text)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(textColor)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if isSelected {
                        Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }
                }
                .background(backgroundColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                )
                .scaleEffect(isSelected ? 1.02 : 1)
                .opacity(isDisabled && !isSelected ? 0.6 : 1)
            }
            .disabled(isDisabled)
            .buttonStyle(PlainButtonStyle())
    }
}
```
**Реализует кнопку ответа с**:
- Ответом
- Изменением цвета фона в зависимости от правильности выбора

### 10. ResultRow
```swift
struct ResultRow: View {
    let title: String
    let value: String
    let systemImage: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Text(value)
                .font(.system(.body, design: .monospaced))
                .bold()
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}
```
Помощник для отображения статистики в конце игры

### 11. CustomTextField
```swift
struct CustomTextField: View {
    let isSecure: Bool
    let title: String
    @Binding var text: String
    @FocusState var isTyping: Bool
    @State private var isSecureField: Bool
    
    init(isSecure: Bool, title: String, text: Binding<String>) {
        self.isSecure = isSecure
        self.title = title
        self._text = text
        self.isSecureField = isSecure
    }
    
    var body: some View {
            if isSecureField {
                ZStack(alignment: .leading){
                    HStack{
                        SecureField("", text: $text).padding(.leading)
                        
                        if isSecure{
                            Button(action:{
                                isSecureField.toggle()
                            }){
                                Image(systemName: isSecureField ? "eye.fill" : "eye.slash.fill")
                                    .resizable()
                                    .frame(width: 26.5, height: 16.5)
                            }
                            .padding(.trailing, 2)
                            .tint(.gitOrange)
                        }
                    }
                    Text(title).padding(.horizontal, 5)
                        .frame(height: 10)
                        .background(.colorBG.opacity(isTyping || !text.isEmpty ? 1 : 0))
                        .foregroundStyle(isTyping ? .gitOrange : Color.primary)
                        .padding(.leading).offset(y: isTyping || !text.isEmpty ? -27 : 0)
                        .onTapGesture {
                            isTyping.toggle()
                        }
                }
                .frame(height: 55).focused($isTyping)
                .background(isTyping ? .gitOrange : Color.primary, in: RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 2))
                .animation(.linear(duration: 0.2), value: isTyping)
                
            } else {
                ZStack(alignment: .leading){
                    HStack{
                        TextField("", text: $text).padding(.leading)
              ....
```
**Создает стилизованное текстовое поле с**:
- Анимированным заголовком
- Переключением видимости пароля
- Интерактивной границей.


### 12. CustomButton
```swift
struct CustomButton: View {
    let title: String
    let action: () -> ()
    var body: some View {
        Button(title, action: action)
            .frame(maxWidth: .infinity, maxHeight: 57)
            .tint(.white)
            .font(.title3)
            .fontWeight(.light)
            .background(.gitOrange, in: RoundedRectangle(cornerRadius: 14))
    }
}
```
**Реализует стилизованную кнопку**


---
🔌 Сервисы
QuestionStorage
```swift
class QuestionStorage {
    static let shared = QuestionStorage()
    private(set) var allQuestions: [Question] = []
    
    func loadQuestions() async throws {
        // Загрузка вопросов из Firestore
    }
}
```
**Реализует**:
- Паттерн Singleton
- Кэширование вопросов
- Парсинг данных из Firestore

## 🧩 Детали реализации

### Работа с Firebase Firestore

#### Коллекции Firestore
| Коллекция       | Описание                                      | Поля (пример)                                |
|-----------------|-----------------------------------------------|----------------------------------------------|
| `profiles`      | Профили пользователей                         | id, name, email, score                       |
| `questions`     | Вопросы для квизов                            | id, text, answers, correctAnswerIndex, hint  |
| `statistics`    | Игровая статистика                            | userId, totalScore, gamesPlayed, ...         |
| `settings`      | Пользовательские настройки                    | userId, language, notifications              |

#### Пример документа `questions`:
```swift
{
  "id": "git-commit",
  "category": "basics",
  "text": "Как создать новый коммит?",
  "answers": [
    "git commit -m 'message'",
    "git add . && git push",
    "git new commit 'message'"
  ],
  "correctAnswerIndex": 0,
  "hint" :[
            "text" : "Используйте флаг -m для сообщения",
            "link" : "https://git-scm.com/docs/git-log"
         ]
}
```
---
## 🔧 Функциональная схема

```plaintext
◄─────►
▲ ▼ ◄ ►
┌─────────────────┐       ┌──────────────────┐
│    UI Layer     │       │   Firebase       │
│                 │       │                  │
│  HomeView       │       │ Firestore        │
│  GameView       │       │ (Questions,      │
│  ProfileView    │       │  Profiles,       |
|  SettingsView   |       |  Settings,       |
|                 |       |  Statistics)     │
│                 │       │                  │
└───────▲─────────┘       └─────────────▲────┘
        │                               │
        │                               │
┌───────▼──────────────┐       ┌────────┴─────────┐
│  ViewModel           │       │  Services        │
│                      │       │                  │
│ GameViewModel        │◄─────►│ FirestoreService │
│ SettingsViewModel    |◄─────►│ AuthService      │
│ LeaderboardViewModel │       │ StatisticsManager│
└──────────────────────┘       └──────────────────┘
```
---
### 1. Слои архитектуры
- **a. UI Layer (Пользовательский интерфейс)**
- Что содержит:
  - Все SwiftUI-представления (HomeView, GameView, ResultsView и т.д.)
  - Визуальные компоненты (кнопки, списки, анимации)
  - Обработку жестов и навигацию
  
- **Примеры взаимодействия**:
  - Пользователь нажимает "Играть" → HomeView запускает навигацию к GameView
  - Ошибка загрузки данных → ErrorView показывает сообщение

- **b. ViewModel Layer (Бизнес-логика)**
- Что делает:
  - Преобразует данные из Firebase в формат для UI
  - Обрабатывает пользовательские действия (нажатия кнопок)
  - Управляет состоянием приложения (загрузка, ошибки)

- **Пример**:
  - GameViewModel:
      - Загружает вопросы через QuestionStorage
      - Считает очки
      - Определяет, когда показывать подсказки

- **c. Services Layer (Работа с данными)**
- Функционал:
  -  QuestionStorage: Кэширует вопросы из Firestore
  -  FirestoreService: CRUD-операции с профилями и статистикой
  -  AuthService: Управление аутентификацией
- Пример запроса:
  - FirestoreService.getProfile() → Получает данные пользователя

### 2. Потоки данных
**a. Запуск теста**:
  - Пользователь: Нажимает "Играть" на HomeView
  - UI Layer: Передает выбранные настройки в GameViewModel

- **ViewModel**:
  - Запрашивает вопросы через QuestionStorage
  - Начинает отсчет времени

- **Services**:
  - QuestionStorage проверяет локальный кэш
  - Если данных нет → Загружает из Firestore

**b. Сохранение результатов**:
- Пользователь: Завершает тест
- UI Layer: GameView → Показывает ResultsView
  
- **ViewModel**:
  - GameViewModel → Формирует объект GameResults
  - Передает данные в StatisticsManager

- **Services**:
  - StatisticsManager → Обновляет статистику в Firestore

**c. Обработка ошибок**:
- Ошибка: Не удалось загрузить вопросы

- **Services**:
  - FirestoreService → Возвращает ошибку
  

- **ViewModel**:
  - GameViewModel → Меняет состояние на .error

- **UI Layer**:
  - GameView → Скрывает индикатор загрузки
  - Показывает ErrorView с кнопкой повтора

### 3. Интеграция с Firebase
- **a. Firestore**
  - Коллекции:
    - questions: Каталог всех вопросов с подсказками
    - profiles: Данные пользователей (имя, аватар, настройки)
    - statistics: Игровая статистика (очки, время, рекорды)
    - settings: Настройки приложения

- **b. Аутентификация**
  - Процесс:
     - Пользователь вводит email/пароль
     - AuthService → Создает запрос к Firebase Auth
     - При успехе → FirestoreService создает/обновляет профиль
  
### 4. Ключевые особенности
- **a. Реактивность**
  - Изменения в Firestore → Мгновенное обновление UI через @Observable


- **b. Безопасность**
  - Правила Firestore:

```javascript
match /profiles/{userId} {
  allow read, write: if request.auth.uid == userId;
}
```
- **c. Оптимизация**
  - Кэширование вопросов → Снижение числа запросов к Firestore
  - Локальная обработка данных → Минимизация задержек

