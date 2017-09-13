From: Jiri Pirko <jiri@resnulli.us>
Date: Wed, 13 Sep 2017 15:18:43 +0200
Subject: [Intel-wired-lan] [RFC PATCH v3 2/7] sched: act_mirred: Traffic
 class option for mirror/redirect action
In-Reply-To: <150529676456.57063.7605464456122745976.stgit@anamdev.jf.intel.com>
References: <150529632024.57063.15338545678487601430.stgit@anamdev.jf.intel.com>
 <150529676456.57063.7605464456122745976.stgit@anamdev.jf.intel.com>
Message-ID: <20170913131843.GB1981@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Wed, Sep 13, 2017 at 11:59:24AM CEST, amritha.nambiar at intel.com wrote:
>Adds optional traffic class parameter to the mirror/redirect action.
>The mirror/redirect action is extended to forward to a traffic
>class on the device if the traffic class index is provided in
>addition to the device's ifindex.

Do I understand it correctly that you just abuse mirred to pas tcclass
index down to the driver, without actually doing anything with the value
inside mirred-code ? That is a bit confusing for me.
