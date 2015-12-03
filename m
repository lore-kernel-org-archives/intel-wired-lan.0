From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 3 Dec 2015 16:53:04 +0000
Subject: [Intel-wired-lan] [PATCH v6] i40e: Look up MAC address in
	Open	Firmware or IDPROM
In-Reply-To: <CAHp75Ve2sLrNZGjD=1LHbyzQEuB2GMhXJxmBgQo1Y4eCHzPk+A@mail.gmail.com>
References: <20151105.103126.148818796422971143.davem@davemloft.net>
 <20151105.110506.1901401372160830603.davem@davemloft.net>
 <CAHp75VfiV6DVb-2piCxmEWFP4Gi-+n0qNhhscvd=UsqXrivVYg@mail.gmail.com>
 <20151105.133131.1900833527415923596.davem@davemloft.net>
 <CAHp75Ve2sLrNZGjD=1LHbyzQEuB2GMhXJxmBgQo1Y4eCHzPk+A@mail.gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96CBB6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I get an error -11 on driver init with this patch applied, I can revert it and everything works normally. Dmesg screenshot is attached, can supply complete dmesg log if needed.
--Andrew


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Andy Shevchenko
> Sent: Thursday, November 05, 2015 11:33 AM
> To: David Miller <davem@davemloft.net>
> Cc: Sowmini Varadhan <sowmini.varadhan@oracle.com>; linux-
> kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; netdev
> <netdev@vger.kernel.org>
> Subject: Re: [Intel-wired-lan] [PATCH v6] i40e: Look up MAC address in Open
> Firmware or IDPROM
> 
> On Thu, Nov 5, 2015 at 8:31 PM, David Miller <davem@davemloft.net>
> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Date: Thu, 5 Nov 2015 20:13:21 +0200
> >
> >> What about
> >>
> >> if (!addr)
> >>  return -ENODATA;
> >
> > I totally disagree.  of_get_phy_mode() and other similar attribute
> > probing mechanisms use -ENODEV.
> 
> Okay, then just
> if (!addr)
>  return -ENODEV;
> 
> --
> With Best Regards,
> Andy Shevchenko
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesgerror.jpg
Type: image/jpeg
Size: 170030 bytes
Desc: dmesgerror.jpg
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151203/f96452e4/attachment-0001.jpg>
