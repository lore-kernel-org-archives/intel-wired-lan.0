From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 29 Mar 2019 11:52:26 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Introduce recovery mode support
In-Reply-To: <20190329182639.78880-1-alice.michael@intel.com>
References: <20190329182639.78880-1-alice.michael@intel.com>
Message-ID: <ee0f9a3b77dc40185779b135c9f0a8c1ccd3aa27.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2019-03-29 at 11:26 -0700, Alice Michael wrote:
> This patch introduces "recovery mode" to the i40e driver. It is
> part of a new Any2Any idea of upgrading the firmware. In this
> approach, it is required for the driver to have support for
> "transition firmware", that is used for migrating from structured
> to flat firmware image. In this new, very basic mode, i40e driver
> must be able to handle particular IOCTL calls from the NVM Update
> Tool and run a small set of AQ commands.
> 
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> Signed-off-by: Piotr Marczak <piotr.marczak@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |   1 +
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  14 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 321 ++++++++++++++++--
>  3 files changed, 305 insertions(+), 31 deletions(-)

Even though I have assigned this to Aaron and Andrew for validation, Don
Buchholz has the setup to test and verify this patch.  Please work with Don
to get this tested.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190329/799cf1a3/attachment.asc>
