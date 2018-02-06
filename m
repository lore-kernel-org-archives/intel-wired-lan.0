From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 06 Feb 2018 13:07:31 -0800
Subject: [Intel-wired-lan] [PATCH] Documentation: networking: Update
 ixgb kconfig select documentation
In-Reply-To: <CAKgT0Uc-br8akeUyjf0FenLPLxDdq14D1rppjvb1yfNU33t+Mw@mail.gmail.com>
References: <1517949734-27314-1-git-send-email-clabbe@baylibre.com>
 <CAKgT0Uc-br8akeUyjf0FenLPLxDdq14D1rppjvb1yfNU33t+Mw@mail.gmail.com>
Message-ID: <1517951251.9683.5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2018-02-06 at 13:01 -0800, Alexander Duyck wrote:
> On Tue, Feb 6, 2018 at 12:42 PM, Corentin Labbe <clabbe@baylibre.com>
> wrote:
> > Update documentation on how to enable ixgb and ixgb DCB.
> > Simply remove NETDEV_10000 and replace it with the new used kconfig
> > names.
> 
> Minor typo in the patch description. I assume you mean "ixgb and
> ixgbe
> DCB". Also you might want to mention ixgbe somewhere in the patch
> title.
> 
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >   Documentation/networking/ixgb.txt  | 3 ++-
> >   Documentation/networking/ixgbe.txt | 7 ++++---
> >   2 files changed, 6 insertions(+), 4 deletions(-)

I alredy have a patch to update the ixgbe kernel documentation, please
see the following patch:
http://patchwork.ozlabs.org/patch/870106/

With my updated documentation patch, the ixgbe hunk of your patch no
longer applies.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180206/544b5faa/attachment.asc>
