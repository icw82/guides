# Передовой опыт

Для https://online.sbis.ru/doc/960ec982-6bde-4463-abd1-5ad052b33a69

## Стилистика кода (общее)

### Ограничение по ширине

Возьмите за правило, писать строки не длиннее 100 символов
(или строже — не длиннее 80). Во-первых это связано с удобством чтения
кода: ограничение ширины позволяет более комфортно передвигаться взгляду,
а так же править код на небольшом дисплее или использовать две параллельно
открытые вкладки в редакторе (например, при редактировании сразу в двух файлах).
Во-вторых, выход кода за рамки установленных границ практически всегда
сигнализирует о проблемах в коде и о том, что он может быть улучшен:
сокращена вложенность кода, сокращены длинные названия переменных
или удалены повторяющиеся участки.

### Висячая запятая

Кратко: висячая запятая позволяет писать код быстрее.
Как минимум, дайте возможность людям писать код быстрее,
не запрещайте использовать висячую запятую.

Видео, в котором это наглядно показано:
https://www.youtube.com/watch?v=OuL6Iu-wNDU

### Читаемая компактность кода

Есть случаи, когда множество аргументов, аттрибутов или свойств записаны
в одну строку. Это не удобно читать. Гораздо комфортнее для чтения и быстрого
распознавания ситуации — размещение их построчно. Можете представить круг,
внутри которого нужно разместить всю необходимую информацию для понимания
обстановки. Это будет круг внимания в момент взгляда и важно не заставлять
себя или кого-то другого тратить время на понимание. Очевидно, длинная строка
не вписывается в этот круг компактно. Важно при это не впадать в противоположную
другую крайность и пытаться стиснуть в рамки код, в ущерб читаемости.
**Читаемость — один из базовых критериев хорошего кода.**

Несколько примеров:

```python
class Person(StatusMixin, TimeStumpsMixin, models.Model):
    name = models.CharField(verbose_name = 'Имя', max_length = 120)
    photo = ImageField(verbose_name = 'Фотография', upload_to = 'images/persons', blank = True)

# ↓ ↓ ↓

class Person(
    StatusMixin,
    TimeStumpsMixin,
    models.Model,
):
    name = models.CharField(
        verbose_name = 'Имя',
        max_length = 120,
    )

    photo = ImageField(
        verbose_name = 'Фотография',
        upload_to = 'images/persons',
        blank = True
    )
```

```html
<header class="eo-req-register__col eo-req-register__col--title">
    <span>...</span>
</header>

<!-- ↓ ↓ ↓ -->

<header class="
    eo-req-register__col
    eo-req-register__col--title
">                   <!-- ↑ сразу видно, что есть модификатор -->
    <span>...</span>
</header>
```

```ts
async getStructure(reportSetId: number, reportId?: number): Promise<IStructure> {
    ...              // ↑ взгляду нужно больше времени,
                     //чтобы понять, какие тут аргументы
}

// ↓ ↓ ↓

async getStructure(
    reportSetId: number,
    reportId?: number
): Promise<IStructure> {
    ...
}
```

### Всегда извещать разработчика об ошибках в рантайме

Худшее, что можно сделать с ошибками — заглушить их без обработки.
Нельзя заставлять тестировщика или программиста проводить глубокие
расследования, выискивая точку, где что-то пошло не так.

И даже если речь идёт об обработке в стиле «дружелюбных ошибок»,
показываемых пользователю, для разработчика развёрнутая информация об ошибке
должна быть представлена в консоли или в ответе метода.

### Проверка аргументов

Во всех функциях, в которые попадают данные без гарантии соблюдения формата,
желательно использовать проверку формата данных. Это позволяет обнаружить многие
ошибки, связанные с отсутствием данных и\или их типом гораздо быстрее.

Например, у вас есть функция, которую использует другой разработчик.
Он может вызывать её с недопустимым набором аргументов, но узнает об этом
не сразу, так как ошибка может всплыть далеко по стек-трейсу или
в каких-то не учтённых редких сценариях.

### Именование

_примеры плохих и хороших названий методов, свойств_

### Не изменять аргументы

_во избежание сайд-эффектов нельзя менять внутренности аргументов.
Например если передан объект, нельзя внутри него ничего записывать,
только читать_

### Константы

### Опции положительные

_whithoutSomething → something = false_

## Стилистика кода (JS, TS)

### Не сравнивать с undefined

`undefined` — незарезервированное слово языка, поэтому есть возможность
использовать его в качестве имени переменной. Эта особенность уничтожает
гарантию корректного сравнения. Зная это, разработчик не будет сравнивать
переменную с `undefined`, так как в противном случае ему бы пришлось
гарантировать его корректное значение, но это бессмысленная затея.
Таким образом, несоблюдение этого правила, говорит об отсутствии
у разработчика соответствующих знаний о языке.

```js
{
    const test = (x, undefined) => console.log(x === undefined);
    test(5); // false
    test(5, 5); // true
}

{
    const test = (x, undefined) => console.log(typeof x === 'undefined');
    test(5); // true
    test(5, 5); // false
}
```

Что делать, когда нужно проверить наличие аргумента?

```js
function(name) {
    if (typeof name === 'undefined') { ... } else { ... }
}
```

Что делать, когда нужно проверить наличие свойства?

Почти всегда подойдёт оператор `in`, но важно знать нюансы его использования —
в некоторых специфичных случаях он не подойдёт и может стать причиной ошибки.

```js
function(props) {
    if ('name' in props) { ... }
}
```

### Избегать for

_Сайд-эффекты, приемущества деклоративного подхода_

### Избегать else

_Отдавать предпочение return, не ветвить код_

### Примитивные типы

_В TS стараться дать определение типам-алиасам примитивов. Например для
идентификаторов:

```ts
(key: number) => {}

//  ↓  ↓  ↓

type: TArticleKey = number;

(key: TArticleKey) => {}
```

### Именованные аргументы

Результатом функции должны быть новые данные, а не изменённые старые.

и → никогда не изменять данные по ссылкам на объекты, переданные аргументами.

### Состояние, дублирующее состояние на бэке — плохо

### Писать чистые функции по возможности

_Сайд-эффекты, исключения_

## Стилистика кода разметки (HTML + CSS)

### Не использовать инлайновые стили

_почему?_

### Семантические названия

_Что это такое и зачем нужно_

### БЭМ и использование модификаторов

_свичи на модификаторах_

## Работа с Wasaby

_(набор сниппетов, принципы организации компонентов, уточняющие базовые)_

## работа с фреймворком отчётности, быстрая настройка окружения

_(несколько рабочих вариантов под различные нужды)_

* *Скрипт забора SDK и дистрибутивов;*
* *Сборщик статики;*
* *Скрипт обновления нескольких реп сразу;*

## Документирование

В документации компонента интерфейса должен быть описан как минимум
один путь до него в пользовательском интерфейсе.
Частая проблема, когда разработчик правит некий код, но не знает, где
он представлен в интерфейсе, а время на это тратить никому не хочется.
