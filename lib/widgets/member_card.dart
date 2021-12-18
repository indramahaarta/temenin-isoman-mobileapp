import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/common/styles.dart';

Widget memberCard(BuildContext context) {
  return SliverList(
    delegate: SliverChildListDelegate(
      [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            right: 16,
            left: 16,
            bottom: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 10.0,
                ),
                child: Text(
                  "Developer Members",
                  style: AppTheme.myTextTheme.headline6?.copyWith(
                    fontSize: 22,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.code,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {},
              )
              // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            _memberTile(
              context,
              "https://csui2020.github.io/static/img/buku_angkatan/ES14.jpg",
              "Dinda Adriani Siregar",
              "Happy Notes",
            ),
            _memberTile(
              context,
              "https://csui2020.github.io/static/img/buku_angkatan/ZN21.jpg",
              "I Made Indra Mahaarta",
              "Deteksi Mandiri",
            ),
            _memberTile(
              context,
              "https://csui2020.github.io/static/img/buku_angkatan/KH24.jpg",
              "Immanuel Gerald Ronaldo Nadeak",
              "Emergency Contacs",
            ),
            _memberTile(
              context,
              "https://csui2020.github.io/static/img/buku_angkatan/ES29.jpg",
              "Marcellino Chris O'Vara",
              "Checklist",
            ),
            _memberTile(
              context,
              "https://csui2020.github.io/static/img/buku_angkatan/GB32.jpg",
              "Muhammad Agil Ghifari",
              "Info Bed Capacity",
            ),
            _memberTile(
              context,
              "https://csui2020.github.io/static/img/buku_angkatan/SR50.jpg",
              "Sabyna Maharani",
              " Tips And Tricks",
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        )
      ],
    ),
  );
}

Widget _memberTile(
    BuildContext context, String image, String name, String module) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(
          20,
        ),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: const Offset(4, 4),
          blurRadius: 10,
          color: Colors.grey.withOpacity(.2),
        ),
        BoxShadow(
          offset: const Offset(-3, 0),
          blurRadius: 15,
          color: Colors.grey.withOpacity(.2),
        )
      ],
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              13,
            ),
          ),
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(name),
        subtitle: Text(
          module,
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ),
  );
}
