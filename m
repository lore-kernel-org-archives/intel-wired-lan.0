From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Sun, 21 May 2017 00:15:02 +0300
Subject: [Intel-wired-lan] [PATCH 0/4] Configuring traffic classes via
 new hardware offload mechanism in tc/mqprio
In-Reply-To: <149524122523.11022.4541073724650541658.stgit@anamdev.jf.intel.com>
References: <149524122523.11022.4541073724650541658.stgit@anamdev.jf.intel.com>
Message-ID: <CAJ3xEMjTDW7sQ5CFmTyR5xMpin_WFFQg-S8imWMBpXWuS1zvVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, May 20, 2017 at 3:58 AM, Amritha Nambiar
<amritha.nambiar@intel.com> wrote:
> The following series introduces a new harware offload mode in tc/mqprio

Wait, we have already a HW QoS model introduced by John F and Co
couple of years ago,  right?

Please elaborate in few sentence if you are extending it/replacing it,
why we want to do that and what are the implications on existing
applications UAPI wise.

Below you just say in the new mode Qos is configured with knobs XYZ --
this is way not enough

> where the TCs, the queue configurations and bandwidth rate limits
> are offloaded to the hardware.


> The i40e driver enables the new mqprio hardware offload mechanism factoring the TCs, queue configuration and bandwidth rates by creating HW channel VSIs.
>
> In this mode, the priority to traffic class mapping and the user specified queue ranges are used to configure the traffic class when the 'hw' option is set to 2. This is achieved by creating HW channels(VSI). A new channel is created for each of the traffic class configuration offloaded via mqprio framework except for the first TC (TC0) which is for the main VSI. TC0 for the main VSI is also reconfigured as per user provided queue parameters. Finally, bandwidth rate limits are set on these traffic classes through the mqprio offload framework by sending these rates in addition to the number of TCs and the queue configurations.
