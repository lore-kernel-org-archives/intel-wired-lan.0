From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 23 Jul 2018 09:24:06 -0700
Subject: [Intel-wired-lan] [RFC PATCH] ixgbe:
 ixgbe_get_completion_timeout() can be static
In-Reply-To: <20180721055327.GA30259@lkp-wsm-ep1>
References: <20180720222934.3568.15842.stgit@ahduyck-green-test.jf.intel.com>
 <20180721055327.GA30259@lkp-wsm-ep1>
Message-ID: <CAKgT0UdHYJdWeh5_bhYViOqVYX7-N9MVHrEj=e1MK7RO7TxjJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jul 20, 2018 at 10:53 PM, kbuild test robot
<fengguang.wu@intel.com> wrote:
>
> Fixes: 23f3effc3f69 ("ixgbe: Refactor queue disable logic to take completion time into account")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>

Jeff do you think you could fold this into the current completion timeout patch?

Thanks.

- Alex
