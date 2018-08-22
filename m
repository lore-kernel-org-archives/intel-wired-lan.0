From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 22 Aug 2018 09:28:08 -0700
Subject: [Intel-wired-lan] [PATCH v3] Documentation: e1000e: Update
 kernel documentation
In-Reply-To: <8a8e1873-fd5c-07d0-0081-8023fa432709@oracle.com>
References: <20180821213913.32528-1-jeffrey.t.kirsher@intel.com>
 <8a8e1873-fd5c-07d0-0081-8023fa432709@oracle.com>
Message-ID: <a7f5325365d3941a31b44e5b8f75ba1b65238775.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-08-22 at 09:04 -0700, Shannon Nelson wrote:
> On 8/21/2018 2:39 PM, Jeff Kirsher wrote:
> > Updated the e1000e kernel documentation with the latest
> > information.
> > Also remove the command line parameters, which do not exist with
> > the
> > in-kernel driver.  Converted the documentation to the RST format.
> > 
> > Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > ---
> > v1/v2: initial documentation update
> > 
> > v3: convert to RST format, remove module parameters that do not
> > exist
> >       and add SPDX header
> 
> It looks like you removed *all* the module parameters - did you
> really 
> want to do that?

Yes, after reviewing the in-kernel driver, the only module parameter is
"debug".  I know our current and past documentation does not show
"debug" as a module parameter, so I working with our documentation team
to come up with useful text/documentation for the debug module
parameter for this document and all our other driver documentation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180822/c36f50a1/attachment.asc>
