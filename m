From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Thu, 10 Sep 2015 21:53:26 +0000
Subject: [Intel-wired-lan] [next PATCH S13 14/15] i40e: fix ip-ip GRE
 encapulation
In-Reply-To: <CAEP_g=86=-5j5Qz9CtWvB10O8zg5JPLO8sJd_xkLtephPmC+9Q@mail.gmail.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-15-git-send-email-catherine.sullivan@intel.com>
 <CAEP_g=88Nu8uOM0jvd1MTWpwy2+nWst9YQEeWibVt2Zm5mpT0A@mail.gmail.com>
 <E8A77B2FB54C194393A5C2A8E3ED1678266F3BA6@CRSMSX102.amr.corp.intel.com>
 <FC41C24E35F18A40888AACA1A36F3E418AF7DB60@fmsmsx115.amr.corp.intel.com>
 <CAEP_g=--LZxDTTVuOBSqCrppyF8p5o-2J0QQDC3=1YXGYxN8VQ@mail.gmail.com>
 <FC41C24E35F18A40888AACA1A36F3E418AF7DC97@fmsmsx115.amr.corp.intel.com>
 <CAEP_g=86=-5j5Qz9CtWvB10O8zg5JPLO8sJd_xkLtephPmC+9Q@mail.gmail.com>
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AF7E39B@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Jesse Gross [mailto:jesse at nicira.com]
> Sent: Wednesday, September 09, 2015 11:02 PM
> 

Thanks, Jesse, for your perseverance.

> >> To make a long story short, it looks like the actual problem here is
> >> that only UDP tunnels are supported (since that is all that is
> checked
> >> in i40e_tx_enable_csum()). In that case, I think you could simply do:
> >>
> >> if ((protocol != IPPROTO_UDP))
> >>     return features & ~(NETIF_F_ALL_CSUM | NETIF_F_GSO_MASK);

Ah, now I see that the GRE support patch for i40e_tx_enable_csum() hasn't been pushed out yet.  This explains some of this discussion.  Okay - for the moment we're dropping this patch, to be reworked when the other patch gets pushed.

I think you're right about simply dropping the use of vxlan_features_check() as it is too specific for our needs.  This will be part of the rework.

sln

