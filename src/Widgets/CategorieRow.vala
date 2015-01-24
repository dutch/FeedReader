public class categorieRow : baseRow {

	private string m_name;
	private Gtk.EventBox m_eventbox;
	private Gdk.Pixbuf m_state_collapsed;
	private Gdk.Pixbuf m_state_expanded;
	private string m_categorieID;
	private string m_parentID;
	private int m_orderID;
	private int m_level;
	private bool m_exists;
	private Gtk.Image m_icon_expanded;
	private Gtk.Image m_icon_collapsed;
	private bool m_collapsed;
	public signal void collapse(bool collapse, string catID);

	public categorieRow (string name, string categorieID, int orderID, string unread_count, string parentID, int level, bool expanded) {
	
		this.get_style_context().add_class("feed-list-row");
		m_level = level;
		m_parentID = parentID;
		m_orderID = orderID;
		m_collapsed = !expanded;
		m_name = name;
		m_exists = true;
		m_categorieID = categorieID;
		m_unread_count = unread_count;
		var rowhight = 30;
		m_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
		m_eventbox = new Gtk.EventBox();
		m_eventbox.set_events(Gdk.EventMask.BUTTON_PRESS_MASK);

		m_icon_expanded = new Gtk.Image.from_file("/usr/share/FeedReader/arrow-down.svg");
		m_icon_collapsed = new Gtk.Image.from_file("/usr/share/FeedReader/arrow-left.svg");

		m_label = new Gtk.Label(m_name);
		m_label.set_use_markup (true);
		m_label.set_size_request (0, rowhight);
		m_label.set_ellipsize (Pango.EllipsizeMode.END);
		m_label.set_alignment(0, 0.5f);

		m_eventbox.button_press_event.connect(() => {
			expand_collapse();
			return true;
		});

		m_revealer = new Gtk.Revealer();
		m_revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_DOWN);
		m_revealer.set_transition_duration(500);

		m_spacer = new Gtk.Label("");
		m_spacer.set_size_request((level-1) * 24, rowhight);


		m_unread = new Gtk.Label("");
		m_unread.set_size_request (0, rowhight);
		m_unread.set_alignment(0.8f, 0.5f);
		set_unread_count(m_unread_count);

		if(m_collapsed)
			m_eventbox.add(m_icon_collapsed);
		else
			m_eventbox.add(m_icon_expanded);
		m_box.pack_start(m_spacer, false, false, 0);
		m_box.pack_start(m_eventbox, false, false, 8);
		m_box.pack_start(m_label, true, true, 0);
		m_box.pack_end(m_unread, false, false, 8);
		m_revealer.add(m_box);
		m_revealer.set_reveal_child(false);
		m_isRevealed = false;
		this.add(m_revealer);
		this.show_all();
	}

	public void expand_collapse()
	{
		if(m_collapsed)
		{
			m_collapsed = false;
			m_eventbox.remove(m_icon_collapsed);
			m_eventbox.add(m_icon_expanded);
			collapse(false, m_categorieID);
		}
		else
		{
			m_collapsed = true;
			m_eventbox.remove(m_icon_expanded);
			m_eventbox.add(m_icon_collapsed);
			collapse(true, m_categorieID);
		}
		
		this.show_all();
	}

	public string getID()
	{
		return m_categorieID;
	}
	
	public string getName()
	{
		return m_name;
	}

	public string getParent()
	{
		return m_parentID;
	}
	
	public int getOrder()
	{
		return m_orderID;
	}

	public int getLevel()
	{
		return m_level;
	}

	public void setExist(bool exists)
	{
		m_exists = exists;
	}

	public bool doesExist()
	{
		return m_exists;
	}

	public bool isExpanded()
	{
		return !m_collapsed;
	}

}
