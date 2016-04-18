From: KY Srinivasan <kys@microsoft.com>
Date: Mon, 18 Apr 2016 19:42:41 +0000
Subject: [Intel-wired-lan] [PATCH net-next V2 2/2] intel: ixgbevf:
 Support Windows hosts (Hyper-V)
In-Reply-To: <1460998819.1917.10.camel@perches.com>
References: <1460956943-17560-1-git-send-email-kys@microsoft.com>
 <1460956969-17601-1-git-send-email-kys@microsoft.com>
 <1460956969-17601-3-git-send-email-kys@microsoft.com>
 <CAKgT0UdLxSk6CKVAt232fdthMtUbn9FLru9Q9w1Qjjdv_zKA4g@mail.gmail.com>
 <BL2PR03MB19081E9C9AAB13E6F608D08FA06B0@BL2PR03MB1908.namprd03.prod.outlook.com>
 <1460998819.1917.10.camel@perches.com>
Message-ID: <BL2PR03MB1908C6ACA740D30D502942F0A06B0@BL2PR03MB1908.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Joe Perches [mailto:joe at perches.com]
> Sent: Monday, April 18, 2016 10:00 AM
> To: KY Srinivasan <kys@microsoft.com>; Alexander Duyck
> <alexander.duyck@gmail.com>
> Cc: David Miller <davem@davemloft.net>; Netdev
> <netdev@vger.kernel.org>; linux-kernel at vger.kernel.org;
> devel at linuxdriverproject.org; olaf at aepfle.de; Robo Bot
> <apw@canonical.com>; Jason Wang <jasowang@redhat.com>;
> eli at mellanox.com; jackm at mellanox.com; yevgenyp at mellanox.com; John
> Ronciak <john.ronciak@intel.com>; intel-wired-lan <intel-wired-
> lan at lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [PATCH net-next V2 2/2] intel: ixgbevf: Support
> Windows hosts (Hyper-V)
> 
> On Mon, 2016-04-18 at 16:52 +0000, KY Srinivasan wrote:
> []
> > > > +bool ixgbevf_on_hyperv(struct ixgbe_hw *hw)
> > > > +{
> > > > +???????if (hw->mbx.ops.check_for_msg == NULL)
> > > > +???????????????return true;
> > > > +???????else
> > > > +???????????????return false;
> > > > +}
> 
> trivia:
> 
> bool func(...)
> {
> 	if (<bar>)
> 		return true;
> 	else
> 		return false;
> }
> 
> can generally be written as:
> 
> bool func(...)
> {
> 	return <bar>;
> }

Thanks Joe; will update.

K. Y
