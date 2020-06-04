#define LFDefaults [NSUserDefaults standardUserDefaults]
#define LFStorageKey @"lf_storage_key"
// #define LFFile(path) @"/Library/PreferenceLoader/Perferences/LFWeChat/" #path
#define LFFile(path) @"/Library/Caches/LFWeChat/" #path

%hook FindFriendEntryViewController

- (long long)numberOfSectionsInTableView:(UITableView *)arg1 
{
    return %orig + 1;
}

- (long long)tableView:(UITableView *)tableView numberOfRowsInSection:(long long)section
{
    if (section != 6)
    {
        return %orig;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if ([indexPath section] != 6)
    {
        return %orig;
    }

    UITableViewCell *cell = nil;
    if ([indexPath row] == 0)
    {
        NSString *autoCellId = @"autoCellId";
        cell = [tableView dequeueReusableCellWithIdentifier:autoCellId];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:autoCellId];
        }

        UISwitch *s = [[UISwitch alloc] init];
        s.on = [LFDefaults boolForKey:LFStorageKey];
        [s addTarget:self action:@selector(lf_switchChange:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = s;
        cell.textLabel.text = @"自动抢红包";
        cell.accessoryView.hidden = NO;

    } else if ([indexPath row] == 1) {

        NSString *exitCellId = @"exitCellId";
        cell = [tableView dequeueReusableCellWithIdentifier:exitCellId];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exitCellId];
        }
        cell.textLabel.text = @"退出微信";
        cell.accessoryView.hidden = YES;
    }

    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageWithContentsOfFile:LFFile(skullo.png)];
    return cell;
}

- (double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if ([indexPath section] != 6)
    {
        return %orig;
    } else {
        return 44;
    }
}

// 修复点击崩溃的问题
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] != 6)
    {
        return %orig;
    }  else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if ([indexPath row] == 1)
        {
            // exit(0);
            //终止进程
            abort();
        }
    }
}

%new
- (void)lf_switchChange:(UISwitch *)switchView {
    [LFDefaults setBool:switchView.on forKey:LFStorageKey];
    [LFDefaults synchronize];
}

%end