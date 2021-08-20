From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 20 Aug 2021 17:49:08 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 0/3] iavf: Fix init and
 watchdog state machines
In-Reply-To: <20210819084731.2344-1-mateusz.palczewski@intel.com>
References: <20210819084731.2344-1-mateusz.palczewski@intel.com>
Message-ID: <c8d26943460bf9370a7116519be67fdbb27fc6f8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-08-19 at 08:47 +0000, Mateusz Palczewski wrote:
> Use single state machine for driver initialization
> and for service initialized driver. The init state
> machine implemented in init_task() is merged
> into the watchdog_task(). The init_task() function
> is removed.

I've applied this, however, I've removed the fixes tags. It's not clear
to me how or what the refactor or single state machine is fixing. If
you disagree, please resubmit with explanations of the current problem
and how this fixes it in the descriptions.

Thanks,
Tony
