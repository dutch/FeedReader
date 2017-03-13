//--------------------------------------------------------------------------------------
// This is the plugin that extends user-interface of FeedReader
// It adds all the necessary widgets to the interface to log into the service.
// User- and password-entries, or redirect to a website to log in.
//--------------------------------------------------------------------------------------

public class FeedReader.feedwranglerLoginWidget : Peas.ExtensionBase, LoginInterface {
	private Gtk.Entry m_userEntry;
	private Gtk.Entry m_passwordEntry;

	//--------------------------------------------------------------------------------------
	// Called when loading plugin. Setup all the widgets here and add them to
	// m_stack and m_listStore.
	// The signal "login()" can be emmited when try to log in.
	// For example after pressing "enter" in the password-entry.
	//--------------------------------------------------------------------------------------
	public void init()
	{

	}


	//--------------------------------------------------------------------------------------
	// Return the the website/homepage of the project
	//--------------------------------------------------------------------------------------
	public string getWebsite()
	{
		return "https://feedwrangler.net";
	}


	//--------------------------------------------------------------------------------------
	// Return an unique id for the backend. Basically a short form of the name:
	// Tiny Tiny RSS -> "ttrss"
	// Local Backend -> "local"
	//--------------------------------------------------------------------------------------
	public string getID()
	{
		return "feedwrangler";
	}


	//--------------------------------------------------------------------------------------
	// Return flags describing the type of Service
	// - LOCAL
	// - HOSTED
	// - SELF_HOSTED
	// - FREE_SOFTWARE
	// - PROPRIETARY
	// - FREE
	// - PAID_PREMIUM
	// - PAID
	//--------------------------------------------------------------------------------------
	public BackendFlags getFlags()
	{
		return BackendFlags.PAID | BackendFlags.PROPRIETARY | BackendFlags.HOSTED;
	}


	//--------------------------------------------------------------------------------------
	// Return the login UI inside a Gtk.Box (username- and password-entries)
	// Return 'null' if use web-login
	//--------------------------------------------------------------------------------------
	public Gtk.Box? getWidget()
	{
		var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
		box.valign = Gtk.Align.CENTER;
		box.halign = Gtk.Align.CENTER;

		var loginLabel = new Gtk.Label(_("Please login to Feed Wrangler"));
		loginLabel.get_style_context().add_class("h2");
		loginLabel.set_justify(Gtk.Justification.CENTER);
		loginLabel.set_lines(3);
		box.pack_start(loginLabel, false, false, 10);

		var logo = new Gtk.Image.from_icon_name("feed-service-feedwrangler", Gtk.IconSize.MENU);
		box.pack_start(logo, false, false, 10);

		var grid = new Gtk.Grid();
		grid.set_column_spacing(10);
		grid.set_row_spacing(10);
		grid.set_valign(Gtk.Align.CENTER);
		grid.set_halign(Gtk.Align.CENTER);

		var userLabel = new Gtk.Label(_("Username:"));
		userLabel.set_alignment(1.0f, 0.5f);
		userLabel.set_hexpand(true);
		grid.attach(userLabel, 0, 0, 1, 1);

		m_userEntry = new Gtk.Entry();
		m_userEntry.activate.connect(writeData);
		grid.attach(m_userEntry, 1, 0, 1, 1);

		var passwordLabel = new Gtk.Label(_("Password:"));
		passwordLabel.set_alignment(1.0f, 0.5f);
		passwordLabel.set_hexpand(true);
		grid.attach(passwordLabel, 0, 1, 1, 1);

		m_passwordEntry = new Gtk.Entry();
		m_passwordEntry.activate.connect(writeData);
		grid.attach(m_passwordEntry, 1, 1, 1, 1);

		box.pack_start(grid, true, true, 10);

		var loginButton = new Gtk.Button.with_label(_("Login"));
		loginButton.halign = Gtk.Align.END;
		loginButton.set_size_request(80, 30);
		loginButton.get_style_context().add_class(Gtk.STYLE_CLASS_SUGGESTED_ACTION);
		loginButton.clicked.connect(() => { login(); });
		box.pack_end(loginButton, false, false, 10);

		return box;
	}


	//--------------------------------------------------------------------------------------
	// Return the name of the service-icon (non-symbolic).
	//--------------------------------------------------------------------------------------
	public string iconName()
	{
		return "feed-service-feedwrangler";
	}


	//--------------------------------------------------------------------------------------
	// Return the name of the service as displayed to the user
	//--------------------------------------------------------------------------------------
	public string serviceName()
	{
		return "Feed Wrangler";
	}


	//--------------------------------------------------------------------------------------
	// Return wheather the plugin needs a webview to log in via oauth.
	//--------------------------------------------------------------------------------------
	public bool needWebLogin()
	{
		return false;
	}


	//--------------------------------------------------------------------------------------
	// Only important for self-hosted services.
	// If the server is secured by htaccess and a second username and password
	// is required, show the UI to enter those in this methode.
	// If htaccess won't be needed do nothing here.
	//--------------------------------------------------------------------------------------
	public void showHtAccess()
	{

	}

	//--------------------------------------------------------------------------------------
	// Methode gets executed before logging in. Write all the data gathered
	// into gsettings (password, username, access-key).
	//--------------------------------------------------------------------------------------
	public void writeData()
	{

	}


	//--------------------------------------------------------------------------------------
	// Do stuff after a successful login
	//--------------------------------------------------------------------------------------
	public async void postLoginAction()
	{

	}


	//--------------------------------------------------------------------------------------
	// Only needed if "needWebLogin()" retruned true. Return URL that should be
	// loaded to log in via website.
	//--------------------------------------------------------------------------------------
	public string buildLoginURL()
	{
		return "https://feedwrangler.com";
	}


	//--------------------------------------------------------------------------------------
	// Extract access-key from redirect-URL from webview after loggin in with
	// the webview.
	// Return "true" if extracted sucessfuly, "false" otherwise.
	//--------------------------------------------------------------------------------------
	public bool extractCode(string redirectURL)
	{
		return true;
	}
}


//--------------------------------------------------------------------------------------
// Boilerplate code for the plugin. Replace "demoLoginWidget" with the name
// of your interface-class.
//--------------------------------------------------------------------------------------
[ModuleInit]
public void peas_register_types(GLib.TypeModule module)
{
	var objmodule = module as Peas.ObjectModule;
	objmodule.register_extension_type(typeof(FeedReader.LoginInterface), typeof(FeedReader.feedwranglerLoginWidget));
}
