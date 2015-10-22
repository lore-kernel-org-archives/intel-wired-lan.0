From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Thu, 22 Oct 2015 18:58:58 +0300
Subject: [Intel-wired-lan] [RFC Patch 00/12] IXGBE: Add live migration
	support for SRIOV NIC
In-Reply-To: <1445455227.4059.867.camel@redhat.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <CAJ3xEMiStMJdGjgO9=MQrhLpBo8ZiTRoOL_P=aC9kyrNi91FSw@mail.gmail.com>
 <1445455227.4059.867.camel@redhat.com>
Message-ID: <CAJ3xEMhgzfbGf-3Z7GJGxg5VqbWGyKqoTt6c4C54sDNehdXVMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 21, 2015 at 10:20 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:

> This is why the typical VF agnostic approach here is to using bonding
> and fail over to a emulated device during migration, so performance
> suffers, but downtime is something acceptable.

bonding in the VM isn't a zero touch solution, right? is it really acceptable?
