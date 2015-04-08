From: Hisashi T Fujinaka <htodd@twofifty.com>
Date: Wed, 8 Apr 2015 14:15:43 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] e1000e: Cleanup handling of VLAN_HLEN
 as a part of max frame size
In-Reply-To: <20150408204630.4643.37880.stgit@ahduyck-vm-fedora22>
References: <alpine.NEB.2.11.1504081019220.3388@chris.i8u.org>
 <20150408204630.4643.37880.stgit@ahduyck-vm-fedora22>
Message-ID: <alpine.NEB.2.11.1504081413510.3388@chris.i8u.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 8 Apr 2015, Alexander Duyck wrote:

> Fixes: c751a3d58cf2d ("e1000e: Correctly include VLAN_HLEN when changing interface MTU")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> ---
>
> I have only build tested this though I am 99% sure the fixes here are
> correct.  This patch should fix issues on 82573 and ich8 w/ setting an MTU
> of 1500, and for the PCH series w/ setting an MTU of 9000.

Since the original fix was something submitted by Red Hat, can you check
that you're not re-breaking whatever it was that Red Hat thought they
were fixing?
