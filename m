From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 20 Jan 2021 22:17:05 +0000
Subject: [Intel-wired-lan] [PATCH net v4 1/2] i40e: Revert "i40e: don't
 report link up for a VF who hasn't enabled queues"
In-Reply-To: <DM6PR11MB2876AD6ADFBAB24F8BA8D631E5A29@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20210118193454.275037-1-arkadiusz.kubalewski@intel.com>
 <20210118193454.275037-2-arkadiusz.kubalewski@intel.com>
 <a1480517830b533099bf5ce90e09a9fd5c00504e.camel@intel.com>
 <DM6PR11MB2876AD6ADFBAB24F8BA8D631E5A29@DM6PR11MB2876.namprd11.prod.outlook.com>
Message-ID: <b7c9cd467a21cd531e3d22c6388c1f95d582bb38.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-01-20 at 10:17 +0000, Loktionov, Aleksandr wrote:
> Good day Anthony
> 
> This is the first time we push a revert commit. /*we thought that CL
> should be enough, and provided standard revert commit message from
> GIT*/
> Can you link us to example of good revert commit message?

Here are a few links to some reverts to Intel drivers:

https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-
queue.git/commit/?id=6cecf02e77ab9bf97e9252f9fcb8f0738a6de12c

https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=caff422ea81e144842bc44bab408d85ac449377b

https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=0a92892c69bd01b1a9481ef49587f60e97c64042


Thanks,
Tony
