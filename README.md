# AI Interview Coach

> An AI-powered interview preparation platform built with Flutter to help students move confidently from **Campus to Corporate**.

AI Interview Coach is a cross-platform mobile application for structured interview preparation, mock interviews, answer evaluation, resume/document analysis, and personalized career improvement. The project is designed around a simple goal: give students practical preparation, useful feedback, and a clearer path to placement readiness.

## Why this project

Preparing for a technical interview is more than memorizing questions. Candidates need to practice communicating their thoughts, improve weak areas, understand their target role, and receive feedback they can act on. AI Interview Coach brings these activities together in one focused experience.

## Key features

- **Personalized interview preparation** based on job role and difficulty
- **AI-assisted mock interview workflow** for realistic practice
- **Interview history** to review previous sessions and track improvement
- **Answer evaluation** with structured feedback
- **Resume and document analysis** for more focused preparation
- **Voice-based interview practice** using speech-to-text
- **Interview timer and recording experience** for realistic sessions
- **Authentication and profile management**
- **Subscription-ready architecture** for future premium features
- **Responsive Flutter UI** for Android, iOS, web, desktop, and other supported Flutter platforms

## Tech stack

| Area | Technology |
| --- | --- |
| Frontend | Flutter |
| Language | Dart |
| Backend services | Supabase |
| Authentication and data | Supabase Flutter |
| Voice input | `speech_to_text` |
| State and feature organization | Provider-based application architecture |
| Testing | Flutter Test |
| Code quality | Flutter Lints |

## Project structure

```text
lib/
├── app/                 # App configuration, routes, and theme
├── config/              # Supabase and environment configuration
├── core/                # Constants, services, utilities, and shared widgets
├── models/              # Typed application models
├── providers/           # Authentication and feature state
└── screens/             # Auth, home, interview, history, and setup flows

supabase/
└── migrations/          # Database schema and security migrations

test/                    # Unit and widget tests
```

## Getting started

### Prerequisites

- Flutter SDK 3.x or later
- Dart SDK compatible with the project
- Android Studio or Xcode for mobile development
- A Supabase project for backend features

### Installation

```bash
git clone https://github.com/sudheerxdev/ai_interview_coach.git
cd ai_interview_coach
flutter pub get
```

Configure the Supabase values used by the application, then run:

```bash
flutter run
```

To check the project and run tests:

```bash
flutter analyze
flutter test
```

## Product flow

1. Create an account or sign in.
2. Select a target role, difficulty, and interview preferences.
3. Practice questions through the guided interview experience.
4. Submit typed or spoken answers.
5. Review feedback and evaluation results.
6. Use interview history to identify progress and improvement areas.

## Placement opportunity: Flutter Engineer

This project demonstrates practical skills relevant to the **Flutter Engineer** role announced by **Azisly Technologies Private Limited** for the 2027 passing-out batch.

### Role snapshot

- **Company:** Azisly Technologies Private Limited
- **Product domain:** AI-powered EdTech / Career Technology
- **Role:** Flutter Engineer
- **Location:** Gurgaon
- **Type:** Full-time
- **CTC:** 8–10 LPA, based on performance
- **Training period:** 6 months
- **Drive mode:** Virtual
- **Expected joining:** To be communicated
- **Openings:** 1 seat
- **Competition:** Approximately 1,00,000 candidates are expected to compete for this single seat

### Skills demonstrated in this project

- Dart and Flutter fundamentals
- Object-oriented programming
- Reusable and responsive UI development
- REST/API-oriented application integration
- Authentication and backend service integration
- State management and feature-based architecture
- Audio and speech-to-text integration
- Debugging and error-state handling
- Interview workflow, timers, and session history
- Unit and widget testing
- Git and collaborative software-development practices

### Selection process

According to the placement notification:

1. Resume shortlisting
2. Technical / aptitude written test
3. Personal interview

### Eligibility mentioned in the notification

- B.Tech: CSE, IT, AI, Data Science, or ECE
- MCA or M.Tech (CSE)
- 2027 passing-out batch
- Strong fundamentals in Dart, Flutter, OOP, data structures, REST API integration, Git, debugging, and mobile UI development
- Academic or personal Flutter projects preferred

### Registration

Registration is mandatory through the official portals:

- [AKTU ERP](https://erp.aktu.ac.in/)
- [URiSE Student Login](https://urise.up.gov.in/student/login)

The notification mentions **26 October 2026** as the registration deadline. Candidates should verify the latest instructions on the official AKTU portal before applying and update their resume on the ERP college login.

## About the hiring organization

According to the notification, **Azisly.ai** is an AI-powered career-readiness platform focused on bridging the gap between Campus and Corporate. Its product direction includes resume building, domain preparation, interview preparation, and AI-powered mock interviews.

- Website: [azisly.ai](https://azisly.ai/)

## Roadmap

- Improve AI feedback quality and personalization
- Add more role-specific question banks
- Expand analytics for interview performance
- Add richer resume and job-description matching
- Improve accessibility and offline-friendly experiences
- Add automated release pipelines and broader test coverage

## Contributing

Contributions are welcome. Please create a feature branch, keep changes focused, run `flutter analyze` and `flutter test`, and open a pull request with a clear description of the change.

## License

This project is currently maintained as a private/non-published application. Licensing terms can be added when the project is released publicly.

## Contact

For placement-related queries mentioned in the notification, contact **tnp.aktu@aktu.ac.in**. For project-related discussions, please open an issue in this repository.
# CareerPulse-AI-Powered-Mock-Interview-Career-Prep-App
