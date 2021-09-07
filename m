From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 7 Sep 2021 16:36:10 +0200
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix refreshing iavf
 adapter stats on ethtool request
In-Reply-To: <BN6PR11MB1379FBBAAE7D9B2E528C0641F0D39@BN6PR11MB1379.namprd11.prod.outlook.com>
References: <20210903064846.71507-1-jedrzej.jagielski@intel.com>
 <f4a7fedd-968f-f683-f3ac-a444a927d397@molgen.mpg.de>
 <BN6PR11MB1379FBBAAE7D9B2E528C0641F0D39@BN6PR11MB1379.namprd11.prod.outlook.com>
Message-ID: <631fde8d-bf40-95e3-3bf1-241c63d8fc9f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear J?drzej,


Am 07.09.21 um 14:54 schrieb Jagielski, Jedrzej:

> "Should the summary have a net prefix or so? Also shorter:
> 
>> iavf: Refresh iavf adapter stats on ethtool request"
> 
> Shouldn't the commit title begin begins with one from the words <fix/add/del/refactor>?

I am not aware of such a rule.

> "Should that be `iavf_schedule_request_stats()`?"
> This function is invoked only from iavf_get_ethtool_stats.

Reading the diff again, I am not sure how I missed that. Sorry for the 
noise.


Kind regards,

Paul
