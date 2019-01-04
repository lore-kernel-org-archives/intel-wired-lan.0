From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 03 Jan 2019 17:12:20 -0800
Subject: [Intel-wired-lan] [PATCH] e1000e: fix a missing check for
 return value
In-Reply-To: <20190103235404.9491-1-jeffrey.t.kirsher@intel.com>
References: <20190103235404.9491-1-jeffrey.t.kirsher@intel.com>
Message-ID: <a41458301e548897a2a53b08cda2b2604bcf5529.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-01-03 at 15:54 -0800, Jeff Kirsher wrote:
> The change is based on the issue found by Kangjie Lu <kjlu@umn.edu>
> where
> we not checking the return value of a register read/write which could
> result
> in a NULL pointer dereference if the read/write fails.
> 
> Since we are only trying to disable the far-end loopback, if the read
> and write of register fails, we do not want to bail out of the
> function.
> We just want to log that it failed to disable and continue on.
> 
> CC: Sasha Neftin <sasha.neftin@intel.com>
> CC: Kangjie Lu <kjlu@umn.edu>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  .../net/ethernet/intel/e1000e/80003es2lan.c   | 31 +++++++++++++--
> ----
>  1 file changed, 21 insertions(+), 10 deletions(-)

v2 coming, I fat fingered a typo
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190103/6edd4350/attachment.asc>
