//
//  test.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import Foundation
import FirebaseFirestore

func addQuestions() {
    let db = Firestore.firestore()
    
    // MARK: - Git Basics (10)
    let q1: [String: Any] = [
        "text": "Что делает команда 'git init'?",
        "answers": ["Создает репозиторий", "Добавляет файлы", "Фиксирует изменения"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Инициализация", "link": "https://git-scm.com/docs/git-init"],
        "category": "Git Basics"
    ]
    
    let q2: [String: Any] = [
        "text": "Как проверить версию Git?",
        "answers": ["git --version", "git check-version", "git status --version"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Проверка установки", "link": "https://git-scm.com/book/ru/v2/Введение-Установка-Git"],
        "category": "Git Basics"
    ]
    
    let q3: [String: Any] = [
        "text": "Для чего .gitignore?",
        "answers": ["Игнорировать файлы", "Хранить пароли", "Настройка шрифтов"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Исключение файлов", "link": "https://git-scm.com/docs/gitignore"],
        "category": "Git Basics"
    ]
    
    let q4: [String: Any] = [
        "text": "Как зафиксировать изменения?",
        "answers": ["git commit -m", "git save", "git update"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Создание коммита", "link": "https://git-scm.com/docs/git-commit"],
        "category": "Git Basics"
    ]
    
    let q5: [String: Any] = [
        "text": "Что делает git status?",
        "answers": ["Показывает статус", "Фиксирует изменения", "Отправляет на сервер"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Состояние репозитория", "link": "https://git-scm.com/docs/git-status"],
        "category": "Git Basics"
    ]
    
    let q6: [String: Any] = [
        "text": "Как добавить все изменения?",
        "answers": ["git add .", "git add all", "git commit -a"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Подготовка файлов", "link": "https://git-scm.com/docs/git-add"],
        "category": "Git Basics"
    ]
    
    let q7: [String: Any] = [
        "text": "Как настроить email?",
        "answers": ["git config user.email", "git set-email", "git email config"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Конфигурация", "link": "https://git-scm.com/book/ru/v2/Настройка-Git-Первоначальная-настройка-Git"],
        "category": "Git Basics"
    ]
    
    let q8: [String: Any] = [
        "text": "Что показывает git log?",
        "answers": ["Историю коммитов", "Файлы в репозитории", "Удаленные ветки"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Журнал изменений", "link": "https://git-scm.com/docs/git-log"],
        "category": "Git Basics"
    ]
    
    let q9: [String: Any] = [
        "text": "Что делает git diff?",
        "answers": ["Показывает различия", "Удаляет файлы", "Создает ветку"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Сравнение изменений", "link": "https://git-scm.com/docs/git-diff"],
        "category": "Git Basics"
    ]
    
    let q10: [String: Any] = [
        "text": "Как отменить изменения в файле?",
        "answers": ["git checkout -- file", "git reset file", "git undo file"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Восстановление файла", "link": "https://git-scm.com/docs/git-checkout"],
        "category": "Git Basics"
    ]
    
    // MARK: - Branching (10)
    let q11: [String: Any] = [
        "text": "Как создать ветку?",
        "answers": ["git branch", "git checkout", "git clone"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Создание веток", "link": "https://git-scm.com/docs/git-branch"],
        "category": "Branching"
    ]
    
    let q12: [String: Any] = [
        "text": "Как переключиться на ветку?",
        "answers": ["git checkout", "git switch", "git move"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Переключение веток", "link": "https://git-scm.com/docs/git-checkout"],
        "category": "Branching"
    ]
    
    let q13: [String: Any] = [
        "text": "Как удалить ветку?",
        "answers": ["git branch -d", "git remove", "git delete"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Удаление веток", "link": "https://git-scm.com/docs/git-branch"],
        "category": "Branching"
    ]
    
    let q14: [String: Any] = [
        "text": "Как объединить ветки?",
        "answers": ["git merge", "git combine", "git join"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Слияние изменений", "link": "https://git-scm.com/docs/git-merge"],
        "category": "Branching"
    ]
    
    let q15: [String: Any] = [
        "text": "Как переименовать ветку?",
        "answers": ["git branch -m", "git rename", "git mv"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Изменение имени", "link": "https://git-scm.com/docs/git-branch"],
        "category": "Branching"
    ]
    
    let q16: [String: Any] = [
        "text": "Что делает git rebase?",
        "answers": ["Перезаписывает историю", "Удаляет коммиты", "Создает копию"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Изменение истории", "link": "https://git-scm.com/docs/git-rebase"],
        "category": "Branching"
    ]
    
    let q17: [String: Any] = [
        "text": "Как разрешить конфликты?",
        "answers": ["Вручную редактировать", "git auto-fix", "git conflict-resolve"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Решение конфликтов", "link": "https://git-scm.com/docs/git-merge#_how_to_resolve_conflicts"],
        "category": "Branching"
    ]
    
    let q18: [String: Any] = [
        "text": "Как сравнить ветки?",
        "answers": ["git diff branch1..branch2", "git compare", "git branch-diff"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Сравнение веток", "link": "https://git-scm.com/docs/git-diff"],
        "category": "Branching"
    ]
    
    let q19: [String: Any] = [
        "text": "Как создать и переключиться?",
        "answers": ["git checkout -b", "git branch -c", "git new-branch"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Новая ветка", "link": "https://git-scm.com/docs/git-checkout"],
        "category": "Branching"
    ]
    
    let q20: [String: Any] = [
        "text": "Как просмотреть ветки?",
        "answers": ["git branch", "git list", "git show-branches"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Список веток", "link": "https://git-scm.com/docs/git-branch"],
        "category": "Branching"
    ]
    
    // MARK: - Remote (10)
    let q21: [String: Any] = [
        "text": "Как клонировать репозиторий?",
        "answers": ["git clone", "git copy", "git download"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Клонирование", "link": "https://git-scm.com/docs/git-clone"],
        "category": "Remote"
    ]
    
    let q22: [String: Any] = [
        "text": "Как отправить изменения?",
        "answers": ["git push", "git send", "git upload"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Отправка на сервер", "link": "https://git-scm.com/docs/git-push"],
        "category": "Remote"
    ]
    
    let q23: [String: Any] = [
        "text": "Как получить изменения?",
        "answers": ["git pull", "git fetch", "git sync"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Обновление данных", "link": "https://git-scm.com/docs/git-pull"],
        "category": "Remote"
    ]
    
    let q24: [String: Any] = [
        "text": "Как добавить удаленный репозиторий?",
        "answers": ["git remote add", "git add-remote", "git repo add"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Управление репозиториями", "link": "https://git-scm.com/docs/git-remote"],
        "category": "Remote"
    ]
    
    let q25: [String: Any] = [
        "text": "Как просмотреть удаленные репозитории?",
        "answers": ["git remote -v", "git list-remote", "git show-remotes"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Список репозиториев", "link": "https://git-scm.com/docs/git-remote"],
        "category": "Remote"
    ]
    
    let q26: [String: Any] = [
        "text": "Как удалить удаленную ветку?",
        "answers": ["git push origin --delete", "git branch -d", "git remove-branch"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Удаление на сервере", "link": "https://git-scm.com/docs/git-push"],
        "category": "Remote"
    ]
    
    let q27: [String: Any] = [
        "text": "Что делает git fetch?",
        "answers": ["Загружает изменения", "Сливает ветки", "Удаляет историю"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Получение данных", "link": "https://git-scm.com/docs/git-fetch"],
        "category": "Remote"
    ]
    
    let q28: [String: Any] = [
        "text": "Как переименовать удаленный репозиторий?",
        "answers": ["git remote rename", "git repo-rename", "git mv-remote"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Изменение имени", "link": "https://git-scm.com/docs/git-remote"],
        "category": "Remote"
    ]
    
    let q29: [String: Any] = [
        "text": "Как обновить URL репозитория?",
        "answers": ["git remote set-url", "git repo-url", "git config-url"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Изменение адреса", "link": "https://git-scm.com/docs/git-remote"],
        "category": "Remote"
    ]
    
    let q30: [String: Any] = [
        "text": "Что делает git remote show?",
        "answers": ["Показывает информацию", "Создает репозиторий", "Удаляет репозиторий"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Информация о репозитории", "link": "https://git-scm.com/docs/git-remote"],
        "category": "Remote"
    ]
    
    // MARK: - Advanced (10)
    let q31: [String: Any] = [
        "text": "Что делает git stash?",
        "answers": ["Сохраняет изменения", "Удаляет файлы", "Создает ветку"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Временное сохранение", "link": "https://git-scm.com/docs/git-stash"],
        "category": "Advanced"
    ]
    
    let q32: [String: Any] = [
        "text": "Как применить stash?",
        "answers": ["git stash pop", "git stash apply", "git restore stash"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Восстановление изменений", "link": "https://git-scm.com/docs/git-stash"],
        "category": "Advanced"
    ]
    
    let q33: [String: Any] = [
        "text": "Что такое git bisect?",
        "answers": ["Поиск бага", "Слияние веток", "Удаление истории"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Бинарный поиск", "link": "https://git-scm.com/docs/git-bisect"],
        "category": "Advanced"
    ]
    
    let q34: [String: Any] = [
        "text": "Как изменить последний коммит?",
        "answers": ["git commit --amend", "git edit-commit", "git change"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Редактирование коммита", "link": "https://git-scm.com/docs/git-commit"],
        "category": "Advanced"
    ]
    
    let q35: [String: Any] = [
        "text": "Что такое подмодули?",
        "answers": ["Вложенные репозитории", "Типы файлов", "Плагины Git"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Git Submodules", "link": "https://git-scm.com/docs/git-submodule"],
        "category": "Advanced"
    ]
    
    let q36: [String: Any] = [
        "text": "Как создать тег?",
        "answers": ["git tag", "git create-tag", "git mark"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Версионирование", "link": "https://git-scm.com/docs/git-tag"],
        "category": "Advanced"
    ]
    
    let q37: [String: Any] = [
        "text": "Что делает git cherry-pick?",
        "answers": ["Переносит коммит", "Удаляет коммит", "Переименовывает коммит"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Выборочное применение", "link": "https://git-scm.com/docs/git-cherry-pick"],
        "category": "Advanced"
    ]
    
    let q38: [String: Any] = [
        "text": "Как отменить rebase?",
        "answers": ["git rebase --abort", "git undo-rebase", "git reset rebase"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Отмена операции", "link": "https://git-scm.com/docs/git-rebase"],
        "category": "Advanced"
    ]
    
    let q39: [String: Any] = [
        "text": "Что такое git hook?",
        "answers": ["Скрипты для событий", "Инструменты CLI", "Типы веток"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Автоматизация задач", "link": "https://git-scm.com/docs/githooks"],
        "category": "Advanced"
    ]
    
    let q40: [String: Any] = [
        "text": "Как сжать историю коммитов?",
        "answers": ["git rebase -i", "git compress", "git squash"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Интерактивный rebase", "link": "https://git-scm.com/docs/git-rebase"],
        "category": "Advanced"
    ]
    
    // MARK: - Undo (10 вопросов)
    let q41: [String: Any] = [
        "text": "Как отменить последний коммит?",
        "answers": ["git reset HEAD~1", "git undo", "git rollback"],
        "correctAnswerIndex": 0,
        "hint": ["text": " ", "link": "https://git-scm.com/docs"],
        "category": "Undo"
    ]
    
    let q42: [String: Any] = [
        "text": "Как отменить все непроиндексированные изменения?",
        "answers": ["git restore .", "git reset --hard", "git clean -f"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Сброс изменений", "link": "https://git-scm.com/docs/git-restore"],
        "category": "Undo"
    ]
    
    let q43: [String: Any] = [
        "text": "Как отменить индексацию файла?",
        "answers": ["git reset HEAD file", "git unstage file", "git rm --cached file"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Удаление из индекса", "link": "https://git-scm.com/docs/git-reset"],
        "category": "Undo"
    ]
    
    let q44: [String: Any] = [
        "text": "Как восстановить удаленную ветку?",
        "answers": ["git checkout -b branch <hash>", "git revive branch", "git undelete branch"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Восстановление через хеш", "link": "https://git-scm.com/docs/git-checkout"],
        "category": "Undo"
    ]
    
    let q45: [String: Any] = [
        "text": "Как отменить слияние с конфликтами?",
        "answers": ["git merge --abort", "git reset --merge", "git undo-merge"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Прерывание слияния", "link": "https://git-scm.com/docs/git-merge"],
        "category": "Undo"
    ]
    
    let q46: [String: Any] = [
        "text": "Как удалить последний тег?",
        "answers": ["git tag -d <tagname>", "git remove-tag", "git undo-tag"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Удаление тегов", "link": "https://git-scm.com/docs/git-tag"],
        "category": "Undo"
    ]
    
    let q47: [String: Any] = [
        "text": "Как отменить git add для всех файлов?",
        "answers": ["git reset", "git restore --staged .", "git unstage-all"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Сброс индекса", "link": "https://git-scm.com/docs/git-reset"],
        "category": "Undo"
    ]
    
    let q48: [String: Any] = [
        "text": "Как восстановить файл из старого коммита?",
        "answers": ["git checkout <hash> -- file", "git revive <hash> file", "git restore-from <hash> file"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Восстановление истории", "link": "https://git-scm.com/docs/git-checkout"],
        "category": "Undo"
    ]
    
    let q49: [String: Any] = [
        "text": "Как переписать историю коммитов?",
        "answers": ["git rebase -i", "git history-edit", "git amend-all"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Интерактивный rebase", "link": "https://git-scm.com/docs/git-rebase"],
        "category": "Undo"
    ]
    
    let q50: [String: Any] = [
        "text": "Как удалить неотслеживаемые файлы и директории?",
        "answers": ["git clean -fd", "git purge", "git remove-untracked"],
        "correctAnswerIndex": 0,
        "hint": ["text": "Глубокая очистка", "link": "https://git-scm.com/docs/git-clean"],
        "category": "Undo"
    ]
    
    // Собираем все вопросы в массив
    let allQuestions = [
        q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, q32, q33, q34, q35, q36, q37, q38, q39, q40, q41, q42, q43, q44, q45, q46, q47, q48, q49, q50
    ]
    
    // Добавляем вопросы в Firestore
    for (index, question) in allQuestions.enumerated() {
        db.collection("questions").addDocument(data: question) { error in
            if let error = error {
                print("Ошибка добавления вопроса \(index + 1): \(error.localizedDescription)")
            } else {
                print("Вопрос \(index + 1) успешно добавлен!")
            }
        }
    }
}
