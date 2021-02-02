From: Alexander Lobakin <alobakin@pm.me>
Date: Tue, 02 Feb 2021 13:13:06 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 0/5] net: consolidate
 page_is_pfmemalloc() usage
In-Reply-To: <20210201171835.690558df@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210131120844.7529-1-alobakin@pm.me>
 <20210201171835.690558df@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <20210202131233.4180-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 1 Feb 2021 17:18:35 -0800

> On Sun, 31 Jan 2021 12:11:16 +0000 Alexander Lobakin wrote:
> > page_is_pfmemalloc() is used mostly by networking drivers to test
> > if a page can be considered for reusing/recycling.
> > It doesn't write anything to the struct page itself, so its sole
> > argument can be constified, as well as the first argument of
> > skb_propagate_pfmemalloc().
> > In Page Pool core code, it can be simply inlined instead.
> > Most of the callers from NIC drivers were just doppelgangers of
> > the same condition tests. Derive them into a new common function
> > do deduplicate the code.
> 
> Please resend, this did not get into patchwork :/

I suspected it would be so as I got reports about undelivered mails
due to unavailability of vger.kernel.org for some reasons Will do.

Al

