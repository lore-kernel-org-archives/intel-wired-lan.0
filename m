From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Wed, 9 Sep 2015 23:32:36 +0000
Subject: [Intel-wired-lan] [next PATCH S13 14/15] i40e: fix ip-ip GRE
 encapulation
In-Reply-To: <E8A77B2FB54C194393A5C2A8E3ED1678266F3BA6@CRSMSX102.amr.corp.intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-15-git-send-email-catherine.sullivan@intel.com>
 <CAEP_g=88Nu8uOM0jvd1MTWpwy2+nWst9YQEeWibVt2Zm5mpT0A@mail.gmail.com>
 <E8A77B2FB54C194393A5C2A8E3ED1678266F3BA6@CRSMSX102.amr.corp.intel.com>
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AF7DB60@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > From: Jesse Gross [mailto:jesse at nicira.com]
> > Sent: Friday, August 28, 2015 4:03 PM
> > To: Sullivan, Catherine
> > Cc: intel-wired-lan
> > Subject: Re: [Intel-wired-lan] [next PATCH S13 14/15] i40e: fix ip-ip
> GRE
> > encapulation

Hi Jesse, thanks for looking at these.  Please excuse this late response and possibly mangled headers, I just got back from sabbatical and am looking at old mail...

> >
> > On Fri, Aug 28, 2015 at 2:56 PM, Catherine Sullivan
> > <catherine.sullivan@intel.com> wrote:
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > index 469e1d5..b686450 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > [...]
> > > +#if IS_ENABLED(CONFIG_VXLAN)
> > > +       return vxlan_features_check(skb, features); #else
> > >         return features;
> > > +#endif
> >
> > I don't think this is right - when VXLAN is compiled in, it will
> restrict offload
> > capabilities to that of VXLAN. But when there is no VXLAN support, all
> tunnel
> > types will be allowed. Presumably, there is some underlying hardware
> > capability here for both situations (and maybe even for GRE as well).

I don't understand where you this restriction.  Looking at the code in vxlan_features_check(), it looks to me that the features bits are mangled only if IPPROTO_UDP is set AND the other header parameters don't match VXLAN needs.  If there is no encapsulation, or it is something other than IPPROTO_UDP (e.g. IPPROTO_GRE), then there is no change to the features bits.

If you are referring to other tunneling protocols that might call themselves IPROTO_UDP, then I would think there is a problem in the implementation of vxlan_features_check(), not in how we call it.  In that case, vxlan_features_check() should be looking at some additional flag to assure VXLAN before verifying the other header parameters.

What am I missing?  Are you thinking that our calling code should look for some additional VXLAN flag before calling vxlan_features_check()?

Thanks,
sln




