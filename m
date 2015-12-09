From: Lan, Tianyu <tianyu.lan@intel.com>
Date: Wed, 9 Dec 2015 19:41:46 +0800
Subject: [Intel-wired-lan] [RFC PATCH V2 0/3] IXGBE/VFIO: Add live
 migration support for SRIOV NIC
In-Reply-To: <20151209132233-mutt-send-email-mst@redhat.com>
References: <CAKgT0Uc+-gFAetEfde6DmMOFK+vDE6UkgsNF8oLNqaQc4USSeg@mail.gmail.com>
 <565DB6FF.1050602@intel.com> <20151201171140-mutt-send-email-mst@redhat.com>
 <CAKgT0UfLEJpV-KdqRGfzBeas8bdqfHCmT5Xc8iVVP03g_pQO8A@mail.gmail.com>
 <20151201193026-mutt-send-email-mst@redhat.com>
 <CAKgT0UfJ7w6yYcZcF2YZyDKEwvE7Gh3P-jfGQGKLfPH2crVBzw@mail.gmail.com>
 <20151202105955-mutt-send-email-mst@redhat.com> <5661C000.8070201@intel.com>
 <20151209122831-mutt-send-email-mst@redhat.com> <56680E33.6040204@intel.com>
 <20151209132233-mutt-send-email-mst@redhat.com>
Message-ID: <5668137A.9090608@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/9/2015 7:28 PM, Michael S. Tsirkin wrote:
> I remember reading that it's possible to implement a bus driver
> on windows if required.  But basically I don't see how windows can be
> relevant to discussing guest driver patches. That discussion
> probably belongs on the qemu maling list, not on lkml.

I am not sure whether we can write a bus driver for Windows to support
migration. But I think device vendor who want to support migration will 
improve their driver if we provide such framework in the
hypervisor which just need them to change their driver.
