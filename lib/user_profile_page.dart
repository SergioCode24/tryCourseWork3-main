import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'user.dart';
import 'article_detail_page.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  UserProfilePage({required this.user});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _formattedDate = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru', null).then((_) {
      setState(() {
        _formattedDate = DateFormat('dd MMMM yyyy', 'ru').format(DateTime.parse(widget.user.dateOfBirth));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль пользователя'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Имя:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.user.name,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Логин:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.user.login,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Пароль:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.user.password,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Дата рождения:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              _formattedDate,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Знак зодиака:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.user.getZodiacSign(),
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Избранные статьи:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.user.favoriteArticles.length,
                itemBuilder: (context, index) {
                  final articleTitle = widget.user.favoriteArticles[index];
                  final article = _findArticleByTitle(articleTitle);

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.network(
                        article['imageUrl']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(article['title']!),
                      subtitle: Text(article['content']!),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetailPage(
                              title: article['title']!,
                              content: article['content']!,
                              zodiacSign: article['zodiacSign']!,
                              date: article['date']!,
                              imageUrl: article['imageUrl']!,
                              isFavorite: true,
                              onToggleFavorite: () {},
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> _findArticleByTitle(String title) {
    // Здесь нужно реализовать поиск статьи по заголовку
    // В данном примере используется список статей из AstrologyHomePage
    final articles = [
      {
        'title': 'Влияние Луны на настроение',
        'content': 'Луна оказывает значительное влияние на наше настроение и эмоциональное состояние. Узнайте больше о том, как фазы Луны могут повлиять на вашу жизнь.',
        'zodiacSign': 'Овен',
        'date': '2023-10-01',
        'imageUrl': 'https://example.com/image1.jpg',
      },
      {
        'title': 'Астрологический прогноз на неделю',
        'content': 'Узнайте, что принесет вам эта неделя по мнению звезд. Подробный астрологический прогноз для всех знаков зодиака.',
        'zodiacSign': 'Телец',
        'date': '2023-10-02',
        'imageUrl': 'https://example.com/image2.jpg',
      },
      {
        'title': 'Как правильно читать гороскоп',
        'content': 'Гороскопы могут быть полезным инструментом для планирования вашей жизни. Узнайте, как правильно читать и интерпретировать гороскопы.',
        'zodiacSign': 'Козерог',
        'date': '2023-10-03',
        'imageUrl': 'https://example.com/image3.jpg',
      },
      // Добавьте больше статей по мере необходимости
    ];

    return articles.firstWhere((article) => article['title'] == title);
  }
}
