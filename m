From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 23 Jun 2020 13:16:28 -0700
Subject: [Intel-wired-lan] [PATCH 03/11] net: devres: relax
 devm_register_netdev()
In-Reply-To: <CAMRc=MfF1RbQCJ62QhscFLu1HKYRc9M-2SMep1_vTJ2xhKjLAA@mail.gmail.com>
References: <20200622100056.10151-1-brgl@bgdev.pl>
 <20200622100056.10151-4-brgl@bgdev.pl>
 <20200622154943.02782b5a@kicinski-fedora-PC1C0HJN>
 <CAMRc=MfF1RbQCJ62QhscFLu1HKYRc9M-2SMep1_vTJ2xhKjLAA@mail.gmail.com>
Message-ID: <20200623131628.232ec75e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 23 Jun 2020 11:12:24 +0200 Bartosz Golaszewski wrote:
> wt., 23 cze 2020 o 00:49 Jakub Kicinski <kuba@kernel.org> napisa?(a):
> > On Mon, 22 Jun 2020 12:00:48 +0200 Bartosz Golaszewski wrote:  
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > This devres helper registers a release callback that only unregisters
> > > the net_device. It works perfectly fine with netdev structs that are
> > > not managed on their own. There's no reason to check this - drop the
> > > warning.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>  
> >
> > I think the reasoning for this suggestion was to catch possible UAF
> > errors. The netdev doesn't necessarily has to be from devm_alloc_*
> > but it has to be part of devm-ed memory or memory which is freed
> > after driver's remove callback.
> >  
> 
> Yes I understand that UAF was the concern here, but this limitation is
> unnecessary. In its current form devm_register_netdev() only works for
> struct net_device allocated with devm_alloc_etherdev(). Meanwhile
> calling alloc_netdev() (which doesn't have its devm counterpart yet -
> I may look into it shortly),

If resource managed alloc_netdev() is needed devm_alloc_netdev() can
be created, and even reuse devm_free_netdev() so no changes to the
warning are even necessary for such extension.

> then registering a devm action with devm_add_action_or_reset() which
> would free this memory is a perfectly fine use case. This patch would
> make it possible.

alloc_netdev() + devm_add_action makes no sense in the upstream kernel,
just add the appropriate helper, we care little about out of tree code.

> > Are there cases in practice where you've seen the netdev not being
> > devm allocated?  
> 
> As I said above - alloc_netdev() used by wireless, can, usb etc.
> drivers doesn't have a devres variant.


