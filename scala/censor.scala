val curseWords = Map("shoot" -> "pucky", "darn" -> "beans")

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

val bitching = new ObsceneText("This darn thing doesn't work. Shoot!")

println(bitching.content)