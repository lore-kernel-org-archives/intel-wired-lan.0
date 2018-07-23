From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 23 Jul 2018 10:35:36 -0700
Subject: [Intel-wired-lan] [RFC PATCH] ixgbe:
 ixgbe_get_completion_timeout() can be static
In-Reply-To: <CAKgT0UdHYJdWeh5_bhYViOqVYX7-N9MVHrEj=e1MK7RO7TxjJA@mail.gmail.com>
References: <20180720222934.3568.15842.stgit@ahduyck-green-test.jf.intel.com>
 <20180721055327.GA30259@lkp-wsm-ep1>
 <CAKgT0UdHYJdWeh5_bhYViOqVYX7-N9MVHrEj=e1MK7RO7TxjJA@mail.gmail.com>
Message-ID: <0670ba769f4eeebf8069dd5ea13477aa7e1f39d5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2018-07-23 at 09:24 -0700, Alexander Duyck wrote:
> On Fri, Jul 20, 2018 at 10:53 PM, kbuild test robot
> <fengguang.wu@intel.com> wrote:
> > 
> > Fixes: 23f3effc3f69 ("ixgbe: Refactor queue disable logic to take
> > completion time into account")
> > Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> 
> Jeff do you think you could fold this into the current completion
> timeout patch?

Yes, I can do that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180723/b1d30cb7/attachment-0001.asc>
