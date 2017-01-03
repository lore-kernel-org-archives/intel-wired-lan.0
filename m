From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Wed, 4 Jan 2017 01:03:54 +0200
Subject: [Intel-wired-lan] [net-next PATCH 5/6] i40e: Add TX and RX
	support in switchdev mode.
In-Reply-To: <586693A6.5090105@intel.com>
References: <1483078863-22026-1-git-send-email-sridhar.samudrala@intel.com>
 <1483078863-22026-6-git-send-email-sridhar.samudrala@intel.com>
 <CAJ3xEMgDAUSE2gVD3dU4UuXFb7k_W-9QgHpg-0c7b5kxRC2=FQ@mail.gmail.com>
 <586693A6.5090105@intel.com>
Message-ID: <CAJ3xEMjGuKKge+_hqZPOg2fp3f50TdxGtbKFXwnCZ70rPxmuyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Dec 30, 2016 at 7:04 PM, Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
> On 12/30/2016 7:31 AM, Or Gerlitz wrote:

>> Are you exposing switchdev ops for the representators? didn't see that
>> or maybe it's in the 4th patch which didn't make it to the list?

> Not at this time. In the future patches when we offload fdb/vlan
> functionality, we could use switchdev ops.

but wait, this is the switchdev mode... even before doing any
offloading, you want (need) your representor netdevices to have the
same HW ID marking they are all ports of the same ASIC, this you can
do with the switchdev parent ID attribute.
