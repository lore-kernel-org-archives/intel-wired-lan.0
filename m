From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 22 Sep 2020 11:35:57 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 4/7] selftests: net: add a
 test for shared UDP tunnel info tables
In-Reply-To: <DM6PR11MB289053EE6E23D53BD4D2126BBC3B0@DM6PR11MB2890.namprd11.prod.outlook.com>
References: <20200722012716.2814777-1-kuba@kernel.org>
 <20200722012716.2814777-5-kuba@kernel.org>
 <SN6PR11MB2896F5ACC5A59F7F330183FFBC3C0@SN6PR11MB2896.namprd11.prod.outlook.com>
 <20200921144408.19624164@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <DM6PR11MB289053EE6E23D53BD4D2126BBC3B0@DM6PR11MB2890.namprd11.prod.outlook.com>
Message-ID: <20200922113557.15a95bf4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 22 Sep 2020 17:34:41 +0000 Brown, Aaron F wrote:
> I should have tunneling enabled as modules, config I was using in
> it's entirety (started with a `make localmodconfig` on a Red Hat
> EL8.x box then started adding modules as needed, so I expect I am
> missing something :)  config follows:

No luck :(

# ./udp_tunnel_nic.sh 
PASSED all 435 checks

Since your failures are on port 1 - which is the config where the
driver sleeps I wonder if this is not a race condition of some sort.

Could you try poking at the values in function check_tables?
The sleep lengths and the retries?
