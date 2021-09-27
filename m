From: Leon Romanovsky <leon@kernel.org>
Date: Mon, 27 Sep 2021 14:53:24 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 13/21] nfp: Move
 delink_register to be last command
In-Reply-To: <20210927083923.GC17484@corigine.com>
References: <cover.1632565508.git.leonro@nvidia.com>
 <f393212ad3906808ee7eb5cff06ef2e053eb9d2b.1632565508.git.leonro@nvidia.com>
 <20210927083923.GC17484@corigine.com>
Message-ID: <YVGwtNEcWSgYvyyV@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 27, 2021 at 10:39:24AM +0200, Simon Horman wrote:
> On Sat, Sep 25, 2021 at 02:22:53PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Open user space access to the devlink after driver is probed.
> 
> Hi Leon,
> 
> I think a description of why is warranted here.

After devlink_register(), users can send GET and SET netlink commands to
the uninitialized driver. In some cases, nothing will happen, but not in
all and hard to prove that ALL drivers are safe with such early access.

It means that local users can (in theory for some and in practice for
others) crash the system (or leverage permissions) with early devlink_register()
by accessing internal to driver pointers that are not set yet.

Like I said in the commit message, I'm not fixing all drivers.
https://lore.kernel.org/netdev/cover.1632565508.git.leonro at nvidia.com/T/#m063eb4e67389bafcc3b3ddc07197bf43181b7209

Because some of the driver authors made a wonderful job to obfuscate their
driver and write completely unmanageable code.

I do move devlink_register() to be last devlink command for all drivers,
to allow me to clean devlink core locking and API in next series.

This series should raise your eyebrow and trigger a question: "is my
driver vulnerable too?". And the answer will depend on devlink_register()
position in the .probe() call.

Thanks

> 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
