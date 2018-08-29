From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Wed, 29 Aug 2018 18:27:41 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] Documentation: ixgb: Prep
 documentation for RST conversion
In-Reply-To: <6444f87a-3e50-54fe-89e8-aa57ed5d451c@oracle.com>
References: <20180829153939.26656-1-jeffrey.t.kirsher@intel.com>
 <6444f87a-3e50-54fe-89e8-aa57ed5d451c@oracle.com>
Message-ID: <61CC2BC414934749BD9F5BF3D5D9404494FD37C4@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Shannon Nelson [mailto:shannon.nelson at oracle.com]
> Sent: Wednesday, August 29, 2018 09:45
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH 1/2] Documentation: ixgb: Prep
> documentation for RST conversion
> 
> On 8/29/2018 8:39 AM, Jeff Kirsher wrote:
> > Before making the conversion to the rst (reStructured Text) format,
> > there are changes needed to the documentation so that there are no build
> errors.
> >
> > Also fixed old/broken URLs to the correct or updated URL.
> >
> > Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > ---
> >   Documentation/networking/ixgb.txt | 484 +++++++++++++-----------------
> >   1 file changed, 214 insertions(+), 270 deletions(-)
> >
> > diff --git a/Documentation/networking/ixgb.txt
> > b/Documentation/networking/ixgb.txt
> > index eccdc4c26af3..86b18330666c 100644
> > --- a/Documentation/networking/ixgb.txt
> > +++ b/Documentation/networking/ixgb.txt
> > @@ -1,7 +1,8 @@
> 
> Add SPDX-License-Identifier?

Yeah, it got added in a later patch.  These 2 ixgb patches had been on my tree for several weeks, I had just forgotten to send them out for review. 

