# MiniJira Board

**Midterm Lab Activity 3 - Group 2**

A simplified task management application inspired by Jira. This Flutter app features a Kanban-style dashboard with live sprint tracking, task CRUD capabilities, and dynamic UI feedback for text limits.

---

## Group Number

**Group 2**

---

## Member List & Assigned Roles

| Name | Role |
| --- | --- |
| **Aguiluz, Josh Andrei** | [Input Role] |
| **Camus, Mark Dave** | [Input Role] |
| **Velasquez, Gabrielle Ainshley** | Project Lead / Integrator |
| **Yamaguchi, Mikaella Gabrielle** | [Input Role] |
| **Yamzon, Jan** | [Input Role] |

---

## Contributions

### Aguiluz, Josh Andrei

* [Input specific tasks here, e.g., Designed the StatBox widget]

### Camus, Mark Dave

* [Input specific tasks here]

### Velasquez, Gabrielle Ainshley

* Set up the project architecture and folder structure.
* Created and designed the `TaskFormScreen` widget.
* Implemented the `Task` model.
* Initially set up the `constants.dart` file.

### Yamaguchi, Mikaella Gabrielle

* [Input specific tasks here]

### Yamzon, Jan

* [Input specific tasks here]

---

## How to Run the App

1. **Install dependencies:**
```bash
flutter pub get
```

2. **Run the application:**

```bash
flutter run
```

3. **For web (optional):**

```bash
flutter run -d chrome
```

---

## Feature Checklist

### Core Functionality (CRUD)

* [ ] **Create:** Users can add new tasks via the Task Form.
* [ ] **Read:** Tasks are displayed in a scrollable list on the main board.
* [ ] **Update:** Users can edit existing task details, priority, and status.
* [ ] **Delete:** Users can remove tasks from the list.

### Sprint Summary & Analytics

* [ ] **Live Stats:** Top row counters (To Do, In Progress, Done) update in real-time.
* [ ] **Summary Card:** Shows "Total Tasks," "Completed," and "Remaining."
* [ ] **Quick Filters:** Buttons to filter the list by "All," "High Priority," or "Done."

### UI & UX Features

* [ ] **Character Counter:**

  * Visual indicator (`X / 120`) while typing descriptions.
  * **Color Logic:** Green (Safe), Orange (Warning), Red (Danger).
  * Prevents saving if the limit is exceeded.

* [ ] **Custom Styling:** Uses the **Cabin** font and a unique color palette.

* [ ] **Reusable Widgets:** Implemented `TaskCard`, `StatBox`, and `PriorityBadge` to reduce code duplication.

---

### Screens

1. **Screen A (Task Board):** Main dashboard with summary, filters, and task list.
2. **Screen B (Task Form):** Shared screen for adding and editing tasks with validation logic.
