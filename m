From: Jakub Kicinski <kuba@kernel.org>
Date: Sat, 30 Jan 2021 11:07:07 -0800
Subject: [Intel-wired-lan] [PATCH v2 net-next 3/4] net: introduce common
 dev_page_is_reserved()
In-Reply-To: <20210130154149.8107-1-alobakin@pm.me>
References: <20210127201031.98544-1-alobakin@pm.me>
 <20210127201031.98544-4-alobakin@pm.me>
 <20210129183907.2ae5ca3d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210130154149.8107-1-alobakin@pm.me>
Message-ID: <20210130110707.3122a360@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 30 Jan 2021 15:42:29 +0000 Alexander Lobakin wrote:
> > On Wed, 27 Jan 2021 20:11:23 +0000 Alexander Lobakin wrote:  
> > > + * dev_page_is_reserved - check whether a page can be reused for network Rx
> > > + * @page: the page to test
> > > + *
> > > + * A page shouldn't be considered for reusing/recycling if it was allocated
> > > + * under memory pressure or at a distant memory node.
> > > + *
> > > + * Returns true if this page should be returned to page allocator, false
> > > + * otherwise.
> > > + */
> > > +static inline bool dev_page_is_reserved(const struct page *page)  
> > 
> > Am I the only one who feels like "reusable" is a better term than
> > "reserved".  
> 
> I thought about it, but this will need to inverse the conditions in
> most of the drivers. I decided to keep it as it is.
> I can redo if "reusable" is preferred.

Naming is hard. As long as the condition is not a double negative it
reads fine to me, but that's probably personal preference.
The thing that doesn't sit well is the fact that there is nothing
"reserved" about a page from another NUMA node.. But again, if nobody
+1s this it's whatever...

That said can we move the likely()/unlikely() into the helper itself?
People on the internet may say otherwise but according to my tests 
using __builtin_expect() on a return value of a static inline helper
works just fine.
