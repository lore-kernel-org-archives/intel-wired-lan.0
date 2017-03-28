From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 28 Mar 2017 15:59:24 +0000
Subject: [Intel-wired-lan] [PATCH 3/5] fm10k: allow service task
	to	reschedule itself
In-Reply-To: <20170112235942.5767-3-jacob.e.keller@intel.com>
References: <20170112235942.5767-1-jacob.e.keller@intel.com>
 <20170112235942.5767-3-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E491465C2@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, January 12, 2017 4:00 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 3/5] fm10k: allow service task to reschedule itself

If some code path executes fm10k_service_event_schedule(), it is guaranteed that we only queue the service task once, since we use __FM10K_SERVICE_SCHED flag. Unfortunately this has a side effect that if a service request occurs while we are currently running the watchdog, it is possible that we will fail to notice the request and ignore it until the next time the request occurs.

This can cause problems with pf/vf mailbox communication and other service event tasks. To avoid this, introduce a FM10K_SERVICE_REQUEST bit. When we successfully schedule (and set the _SCHED bit) the service task, we will clear this bit. However, if we are unable to currently schedule the service event, we just set the new SERVICE_REQUEST bit.

Finally, after the service event completes, we will re-schedule if the request bit has been set.

This should ensure that we do not miss any service event schedules, since we will re-schedule it once the currently running task finishes.
This means that for each request, we will always schedule the service task to run at least once in full after the request came in.

This will avoid timing issues that can occur with the service event scheduling. We do pay a cost in re-running many tasks, but all the service event tasks use either flags to avoid duplicate work, or are tolerant of being run multiple times.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

