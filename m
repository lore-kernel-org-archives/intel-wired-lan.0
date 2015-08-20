From: Singhai, Anjali <anjali.singhai@intel.com>
Date: Thu, 20 Aug 2015 21:03:07 +0000
Subject: [Intel-wired-lan] [PATCH 2/4] geneve: Add geneve udp port
 offload for ethernet devices
In-Reply-To: <1440103042.28850.5.camel@intel.com>
References: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
 <1440096383-8915-2-git-send-email-anjali.singhai@intel.com>
 <1440103042.28850.5.camel@intel.com>
Message-ID: <C40BE8378EF49C44B9184714DBC8EF2992EFAC2D@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is in preparation for making the HW aware of which UDP ports are being used for Geneve packets so that it can do the Geneve offloads.
The TX/RX offload path is common between VXLAN and Geneve where in the skb is marked for encapsulation and the outer transport header determines
if it?s a UDP tunnel. 

Anjali
> -----Original Message-----
> From: Keller, Jacob E
> Sent: Thursday, August 20, 2015 1:37 PM
> To: intel-wired-lan at lists.osuosl.org; Singhai, Anjali
> Subject: Re: [Intel-wired-lan] [PATCH 2/4] geneve: Add geneve udp port
> offload for ethernet devices
> 
> On Thu, 2015-08-20 at 11:46 -0700, Anjali Singhai Jain wrote:
> > Add ndo_ops to add/del UDP ports to a device that supports geneve
> > offload.
> >
> > v2:Added comments for new ndo_ops and minor format fix.
> >
> > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> > ---
> 
> Am I missing something about how this would enable Tx offloads? Or is that
> enabled already?
> 
> Regards,
> Jake
