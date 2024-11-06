import 'package:flutter/material.dart';
import 'article_detail_page.dart';
import 'user.dart';
import 'favorite_button.dart';

class AstrologyHomePage extends StatefulWidget {
  final User user;

  AstrologyHomePage({required this.user});

  @override
  _AstrologyHomePageState createState() => _AstrologyHomePageState();
}

class _AstrologyHomePageState extends State<AstrologyHomePage> {
  final List<Map<String, String>> articles = [
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

  String? selectedZodiacSign;
  String selectedDateFilter = 'All';
  List<String> zodiacSigns = ['Овен', 'Телец', 'Близнецы', 'Рак', 'Лев', 'Дева', 'Весы', 'Скорпион', 'Стрелец', 'Козерог', 'Водолей', 'Рыбы'];
  List<String> dateFilters = ['All', 'Day', 'Week', 'Month'];

  DateTime get currentDate => DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedZodiacSign = widget.user.getZodiacSign();
  }

  List<Map<String, String>> get filteredArticles {
    return articles.where((article) {
      bool zodiacMatch = selectedZodiacSign == null || article['zodiacSign'] == selectedZodiacSign;
      bool dateMatch = true;

      DateTime articleDate = DateTime.parse(article['date']!);

      if (selectedDateFilter == 'Day') {
        dateMatch = articleDate.year == currentDate.year &&
                    articleDate.month == currentDate.month &&
                    articleDate.day == currentDate.day;
      } else if (selectedDateFilter == 'Week') {
        DateTime startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1));
        DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
        dateMatch = articleDate.isAfter(startOfWeek) && articleDate.isBefore(endOfWeek.add(Duration(days: 1)));
      } else if (selectedDateFilter == 'Month') {
        dateMatch = articleDate.year == currentDate.year && articleDate.month == currentDate.month;
      }

      return zodiacMatch && dateMatch;
    }).toList();
  }

  void _toggleFavorite(String title) {
    setState(() {
      if (widget.user.favoriteArticles.contains(title)) {
        widget.user.removeFavoriteArticle(title);
      } else {
        widget.user.addFavoriteArticle(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Астрологические статьи'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Выберите знак зодиака'),
                    value: selectedZodiacSign,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedZodiacSign = newValue;
                      });
                    },
                    items: zodiacSigns.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Выберите фильтр даты'),
                    value: selectedDateFilter,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDateFilter = newValue!;
                      });
                    },
                    items: dateFilters.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      filteredArticles[index]['imageUrl']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(filteredArticles[index]['title']!),
                    subtitle: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Дата: ${filteredArticles[index]['date']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Знак зодиака: ${filteredArticles[index]['zodiacSign']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Image.network(
                            filteredArticles[index]['imageUrl']!,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            filteredArticles[index]['title']!,
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            filteredArticles[index]['content']!,
                            style: TextStyle(fontSize: 14.0),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.0),
                          FavoriteButton(
                            user: widget.user,
                            articleTitle: filteredArticles[index]['title']!,
                            onToggleFavorite: () => _toggleFavorite(filteredArticles[index]['title']!),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailPage(
                            title: filteredArticles[index]['title']!,
                            content: filteredArticles[index]['content']!,
                            zodiacSign: filteredArticles[index]['zodiacSign']!,
                            date: filteredArticles[index]['date']!,
                            imageUrl: filteredArticles[index]['imageUrl']!,
                            isFavorite: widget.user.favoriteArticles.contains(filteredArticles[index]['title']!),
                            onToggleFavorite: () => _toggleFavorite(filteredArticles[index]['title']!),
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
    );
  }
}
