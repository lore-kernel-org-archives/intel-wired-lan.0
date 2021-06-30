From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 30 Jun 2021 22:34:49 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 0/3] iavf: Fix init and
 watchdog state machines
In-Reply-To: <20210628151514.28547-1-mateusz.palczewski@intel.com>
References: <20210628151514.28547-1-mateusz.palczewski@intel.com>
Message-ID: <0e303e027a54af97677f39c556042540af26777f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-06-28 at 15:15 +0000, Mateusz Palczewski wrote:
> Use single state machine for driver initialization
> and for service initialized driver. The init state
> machine implemented in init_task() is merged
> into the watchdog_task(). The init_task() function
> is removed.
> 
> ---
> v5: Fixed the patch so that it applies on net-next tree
> v4: Removed unnecessary line
> v3: Added new file to patch series
> v2: Splitted the patch into 2 to make them smaller
> ---

This is still not applying. Jedrzej recently had apply issues as well.
could you get with him and see how he resolved it?

