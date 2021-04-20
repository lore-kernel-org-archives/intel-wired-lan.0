From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 20 Apr 2021 20:15:57 +0000
Subject: [Intel-wired-lan] [net] igb: Check if num of q_vectors is
 smaller than max before array access.
In-Reply-To: <20210416165952.24401-1-aleksandr.loktionov@intel.com>
References: <20210416165952.24401-1-aleksandr.loktionov@intel.com>
Message-ID: <d5321d7573217a51ee8bc2402db48a068cebb252.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-04-16 at 16:59 +0000, Aleksandr Loktionov wrote:
> Ensure that the adapter->q_vector[MAX_Q_VECTORS] array isn't accessed
> beyond its size. It was fixed by using a local variable num_q_vectors
> as a limit for loop index, and ensure that num_q_vectors is not
> bigger
> than MAX_Q_VECTORS.
> 
> Fixes: 047e0030f1e6 ("igb: add new data structure for handling
> interrupts and NAPI")

The Fixes tag should not be wrapped. It's exempt from the 75 char
limit.

> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Slawomir Laba <slawomirx.laba@intel.com>
> Reviewed-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Verified-by: Mateusz Palczewski <mateusz.placzewski@intel.com>

WARNING: Non-standard signature: Verified-by:

Please fix and resend.
