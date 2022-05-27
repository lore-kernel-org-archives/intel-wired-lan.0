From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 27 May 2022 09:58:00 -0700
Subject: [Intel-wired-lan] [PATCH net v1 1/2] iavf: Add helper to check
 if iavf_remove() is in progress
In-Reply-To: <20220527080919.2370640-1-jedrzej.jagielski@intel.com>
References: <20220527080919.2370640-1-jedrzej.jagielski@intel.com>
Message-ID: <c5ff5e77-f1a0-c298-b747-e9058623002d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/27/2022 1:09 AM, Jedrzej Jagielski wrote:
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the driver checks if the __IAVF_IN_REMOVE_TASK bit is set in
> the adapter's crit_section bitmap. This is fine, but if the
> implementation were to ever change, i.e. a mutex was introduced all of
> the callers of test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)
> would have to change. Fix this by introducing the
> iavf_is_remove_in_progress() helper function.

As I mentioned in patch 2, this refactor should go to net-next, not net.

Thanks,
Tony

> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
