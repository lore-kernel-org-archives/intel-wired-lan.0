From: Ben Greear <greearb@candelatech.com>
Date: Wed, 28 Mar 2018 09:45:53 -0700
Subject: [Intel-wired-lan] e1000e Detected Hardware Unit Hang
In-Reply-To: <1868120618.470456.1522254405085@mail.libero.it>
References: <1969863829.1651192.1521629811656@mail.libero.it>
 <1317189213.22495.1521649183803@mail.libero.it>
 <a97d11e0-6f94-e25c-4362-260073b07219@intel.com>
 <1232121641.66220.1521715209616@mail.libero.it>
 <1104005455.161583.1521817756059@mail.libero.it>
 <4a1bebce-0174-2604-79d4-1fd92a033ff6@intel.com>
 <03dfb3bf-a834-38d3-5371-91b2b079d8e4@candelatech.com>
 <fc97931b-32aa-fd9c-35bd-d3c81a19d87c@intel.com>
 <1868120618.470456.1522254405085@mail.libero.it>
Message-ID: <c3bd257e-4b84-47b4-adfe-ed75b50bfe63@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 03/28/2018 09:26 AM, Marco Berizzi wrote:
>>> Can you add driver code to automatically disable TSO for this chipset
>>> and any others
>>> that need it?
>
> my workaround is to keep the tso enabled and the mtu from 1500 to 9000bytes
>

So you increase the MTU to 9000 and that fixes the problem, or did you set the MTU to
1500 and that fixed the problem?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

