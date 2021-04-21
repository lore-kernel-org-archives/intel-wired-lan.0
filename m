From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 21 Apr 2021 23:04:48 +0000
Subject: [Intel-wired-lan] [net] igb: Check if num of q_vectors is
 smaller than max before array access.
In-Reply-To: <20210421151511.4230-1-aleksandr.loktionov@intel.com>
References: <20210421151511.4230-1-aleksandr.loktionov@intel.com>
Message-ID: <a67c77ec2bfa15baece0de2f9223897b732e218e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-04-21 at 15:15 +0000, Aleksandr Loktionov wrote:
> Ensure that the adapter->q_vector[MAX_Q_VECTORS] array isn't accessed
> beyond its size. It was fixed by using a local variable num_q_vectors
> as a limit for loop index, and ensure that num_q_vectors is not
> bigger
> than MAX_Q_VECTORS.
> 
> Fixes: 047e0030f1e6 ("igb: add new data structure for handling
> interrupts and NAPI")

As I mentioned in the last version, don't wrap the Fixes tag. It can go
over 75 char.

	Fixes tag: Fixes: 047e0030f1e6 ("igb: add new data structure
for handling
		Has these problem(s):
			- Subject has leading but no trailing 	parentheses
			- Subject has leading but no trailing quotes

Also, please remember to indicate revisions with change log when
resending. i.e. this should've been 'v2'. Can you fix the above and
resend as v3?

> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Slawomir Laba <slawomirx.laba@intel.com>
> Reviewed-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Reviewed-by: Mateusz Palczewski <mateusz.placzewski@intel.com>
> ---
