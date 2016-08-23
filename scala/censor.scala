import io.Source, io.Source._

class Text(val content: String)

trait Censor {
  def police(foulwords: String): String = {
    var sanitised_text = foulwords.toLowerCase
    curseWords.foreach { c =>
      sanitised_text = sanitised_text.replaceAll(c._1, c._2)
    }
    return sanitised_text
  }
}

class ObsceneText(c: String) extends Text(c) with Censor {
  override val content = police(c)
}

val curseWords = fromFile("curse_dict").getLines.map {
  l =>
    val Array(k, v, _*) = l.split(',')
    k -> (v)
}.toMap

val bitching = new ObsceneText("This darn thing doesn't work. Shoot!")

println(bitching.content)
