# flutter_movie_app_tmdb

A new Flutter project.

## Getting Started

First: Click on File => Project Structure => Project SDK (I recommend to use Android API 28 Platform).
Second: Click on main.dart => Edit Configurations => Copy "--no-sound-null-safety" into Additional run args.
Third: If you run by click on Run button, it's Ok. If you run by Terminal, you can use this command "flutter run --no-sound-null-safety".

The libraries that I am using in this project include:
- flutter_bloc
- dio
- url_launcher
- cached_network_image
- equatable
- carousel_slider

The architectures that I am using in this project include:
- Dio to call API.
- Bloc to display user interface information from API.

