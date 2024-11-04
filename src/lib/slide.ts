import defaultThumbnail from "../assets/default-thumbnail.webp";

export class SlideRoute {
  slide: string;
  slidePdf: string;
  title: string;
  description: string;
  date: Date;
  session: string;
  tags: string[];
  thumbnail: string;

  constructor(obj: any) {
    this.slide = obj.src_path + "/" + obj.src_file;
    this.slidePdf = obj.src_path + "/" + obj.src_file.replace(".html", ".pdf");
    this.title = obj.title;
    this.description = obj.description;
    this.date = new Date(obj.date);
    this.session = obj.session;
    this.tags = obj.tags;
    this.thumbnail = obj.thumbnail
      ? obj.src_path + "/" + obj.thumbnail
      : defaultThumbnail;
  }
}
