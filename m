From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 25 Feb 2020 21:46:13 +0100
Subject: [Intel-wired-lan] [RFC PATCH v2] e1000e: Use rtnl_lock to
 prevent race conditions between net and pci/pm
In-Reply-To: <681404C7-9015-4C64-B8FE-2C93D75A7318@canonical.com>
References: <CAKgT0UdwqGGKvaSJ+3vd-_d-6t9MB=No+7SpkbOT2PnynRK+2w@mail.gmail.com>
 <20191007172559.11166.29328.stgit@localhost.localdomain>
 <681404C7-9015-4C64-B8FE-2C93D75A7318@canonical.com>
Message-ID: <20200225204613.GA14366@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Feb 25, 2020 at 05:42:26PM +0800, Kai-Heng Feng wrote:
> Hi Greg,
> 
> > On Oct 8, 2019, at 01:27, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> > 
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > 
> > This patch is meant to address possible race conditions that can exist
> > between network configuration and power management. A similar issue was
> > fixed for igb in commit 9474933caf21 ("igb: close/suspend race in
> > netif_device_detach").
> > 
> > In addition it consolidates the code so that the PCI error handling code
> > will essentially perform the power management freeze on the device prior to
> > attempting a reset, and will thaw the device afterwards if that is what it
> > is planning to do. Otherwise when we call close on the interface it should
> > see it is detached and not attempt to call the logic to down the interface
> > and free the IRQs again.
> > 
> >> From what I can tell the check that was adding the check for __E1000_DOWN
> > in e1000e_close was added when runtime power management was added. However
> > it should not be relevant for us as we perform a call to
> > pm_runtime_get_sync before we call e1000_down/free_irq so it should always
> > be back up before we call into this anyway.
> > 
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Please merge this commit, a7023819404ac9bd2bb311a4fafd38515cfa71ec to stable v5.14.
> 
> `modprobe -r e1000e` triggers a null pointer dereference [1] after the the following two patches are applied to v5.4.y:
> d635e7c4b34e6a630c7a1e8f1a8fd52c3e3ceea7 e1000e: Revert "e1000e: Make watchdog use delayed work"
> 21c6137939723ed6f5e4aec7882cdfc247304c27 e1000e: Drop unnecessary __E1000_DOWN bit twiddling

Now queued up, thanks.

greg k-h
